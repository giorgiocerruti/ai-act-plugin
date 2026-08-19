# ai-act-plugin

Plugin Claude Code per la conformità all'**AI Act** — Reg. (UE) 2024/1689 come modificato dal Reg. (UE) 2026/1744 ("Digital Omnibus IA", in vigore dal 27 luglio 2026).

Un command `/ai-act` guidato dalla skill `ai-act-check` porta la valutazione di conformità **dal codice**, non da un questionario: scansiona il repository per componenti di IA, classifica rischio e ruolo, elenca gli obblighi con le scadenze aggiornate, genera i vincoli che gli agenti seguono e produce i documenti per cliente ed end-user. Ogni affermazione legale viene dalla skill e dalle sue `references/` — mai dalla memoria del modello.

> **Non è un parere legale.** Le decisioni di perimetro, la classificazione e le clausole contrattuali vanno validate da un legale. Ogni deliverable esterno chiude col blocco sign-off.

## Installazione

Il repo è già un marketplace Claude Code (`.claude-plugin/marketplace.json`). Da Claude Code:

```
/plugin marketplace add giorgiocerruti/ai-act-plugin
/plugin install ai-act-plugin@ai-act
```

Il primo comando registra il marketplace `ai-act` dal repo GitHub; il secondo installa il plugin. Per aggiornare: `/plugin marketplace update ai-act`.

Requisiti opzionali:
- MCP `clickup` — solo per `/ai-act docs --publish clickup`
- tool `Artifact` — solo per `/ai-act docs --publish artifact`

## Uso

```bash
/ai-act scan                 # inventario dei componenti IA dal codice, classifica, elenca obblighi
/ai-act rules                # emette .claude/rules/ai-act.md che gli agenti leggono durante lo sviluppo
/ai-act docs --client        # brief per il cliente: obblighi per parte, istruzioni art. 13, clausole
/ai-act docs --end-users     # informativa di trasparenza art. 50 per chi è esposto agli output
/ai-act gate                 # questo diff aggiunge un componente IA o cambia la classe di rischio?
/ai-act status               # classificazione, staleness, ignoti, scadenze entro 180 giorni
```

Flag: `--client` / `--end-users` (solo `docs`) · `--publish clickup|artifact|both` (solo `docs`) · `--force-context` (ri-chiede il questionario di contesto).

Senza un primo token riconosciuto, l'intero argomento è trattato come domanda libera: carica la skill e risponde, senza scrivere file.

### Flusso tipico

1. `/ai-act scan` — la prima volta chiede i fatti non deducibili dal codice (ruolo, marchio, chi è esposto, stato del ciclo di vita) e li salva in `00-context.md`. Poi inventaria, classifica, scrive l'assessment.
2. `/ai-act rules` — genera i vincoli per gli agenti, con `globs` derivati dall'inventario (i vincoli si caricano dove vive il codice IA, non altrove).
3. `/ai-act docs --client` e `--end-users` — i due deliverable distinti.
4. `/ai-act gate` prima di una PR, `/ai-act status` per una fotografia.

## Come classifica (skill `ai-act-check`)

Sei fasi, in ordine, senza scorciatoie:

1. **Fatti** — raccolti dall'umano, mai dedotti dal nome del progetto.
2. **Divieti (art. 5)** — per primi, incluso il nuovo art. 5 §1-bis (esito vietato prevedibile e riproducibile senza misure di sicurezza ragionevoli). Se ricorre un divieto, la valutazione si ferma.
3. **Ruolo (art. 3, art. 25)** — non chi scrive il codice, ma con quale nome il sistema arriva sul mercato. Controllati i tre trasferimenti dell'art. 25 §1, la lett. c) esplicitamente.
4. **Classe di rischio (art. 6)** — condizioni cumulative del §1, Allegato III, deroghe del §3 con il knock-out sulla profilazione, art. 50.
5. **Obblighi + scadenze** — da `references/scadenzario.md`, aggiornato dopo il Digital Omnibus.
6. **Output** — struttura fissa a 10 sezioni.

## Artifact prodotti

Committati sotto `{{AI_ACT_DIR}}` (default `docs/compliance/ai-act/`):

| File | Contenuto | Owner |
|------|-----------|-------|
| `00-context.md` | Fatti non deducibili dal codice (ruolo, marchio, esposti, stato) | umano — mai riscritto |
| `01-inventory.md` | Componenti IA trovati, ognuno con `file:line` | auto |
| `02-assessment.md` | Divieti → ruolo → classe → obblighi | auto |
| `03-actions.md` | Azioni dev · azioni cliente · clausole | auto |
| `04-client-brief.md` | Deliverable per il cliente | auto |
| `05-end-user-notice.md` | Informativa art. 50 per gli end-user | auto |
| `99-state.json` | Hash, date, tracking staleness | auto |

Fuori dalla dir: `.claude/rules/ai-act.md` e `docs/wiki/concepts/ai-act.md`.

La dir è **committata**: un secondo run diffa contro il primo, e i "punti di attenzione futuri" diventano un controllo meccanico.

## Configurazione

Il command usa placeholder `{{...}}`. **Il plugin è autonomo: non ha un `/setup`.** Se un placeholder resta letterale a run time viene trattato come non impostato e chiesto via `AskUserQuestion`. Per fissare i default, sostituisci i valori direttamente in `commands/ai-act.md`. Elenco completo in [`CLAUDE.md`](./CLAUDE.md).

I più importanti:
- `{{AI_ACT_ORG_NAME}}` — chi immette il sistema sul mercato col proprio marchio. Decide la qualifica `provider` (art. 3 n. 3). **Mai inventarlo.**
- `{{AI_ACT_SCAN_PATHS}}` — i root che l'inventario scansiona.
- `{{AI_ACT_LEGAL_REVIEWER}}` — chi firma legalmente, stampato nel sign-off.

## Struttura

```
ai-act-plugin/
  .claude-plugin/plugin.json   # manifest
  CLAUDE.md                    # guida per chi lavora sul plugin
  README.md                    # questo file
  commands/ai-act.md           # /ai-act (5 modi)
  skills/ai-act-check/
    SKILL.md                   # le 6 fasi
    references/                # corpo normativo (11 file), unica fonte legale
```

## Provenienza

Estratto da [`claude-infrastructure-template`](https://github.com/giorgiocerruti/claude-infrastructure-template) v2.26.0 (command `/ai-act` + skill `ai-act-check`) come plugin standalone.

## Licenza

MIT
