# ai-act-plugin

Plugin Claude Code per la conformità all'**AI Act** — Reg. (UE) 2024/1689 come modificato dal Reg. (UE) 2026/1744 ("Digital Omnibus IA", in vigore dal 27 luglio 2026).

Un command `/ai-act` guidato dalla skill `ai-act-check` porta la valutazione di conformità **dal codice**, non da un questionario: scansiona il repository per componenti di IA — sia il **codice sorgente** sia la **documentazione di progetto** (README, spec, `docs/`) — classifica rischio e ruolo, elenca gli obblighi con le scadenze aggiornate, genera i vincoli che gli agenti seguono e produce i documenti per cliente ed end-user. Ogni affermazione legale viene dalla skill e dalle sue `references/` — mai dalla memoria del modello. I rilievi tratti dalla documentazione sono sempre marcati `⚠️ NON VERIFICATO`: segnalano, non classificano.

> **Non è un parere legale.** Le decisioni di perimetro, la classificazione e le clausole contrattuali vanno validate da un legale. Ogni deliverable esterno chiude col blocco sign-off.

## Due modi d'uso

Il repo serve due pubblici da un'unica sorgente (`skills/ai-act-check/`):

| Modo | Per chi | Cosa ottieni |
|------|---------|--------------|
| **Plugin Claude Code** | Chi lavora in Claude Code (CLI / IDE / desktop) | Tutto: skill + command `/ai-act` (scan del codice e della documentazione, `file:line`, artifact persistiti, rules, gate, docs) |
| **Skill autonoma** | Chi usa Claude (app claude.ai / desktop) o l'API / Agent SDK | La sola skill `ai-act-check`: triage legale conversazionale. Niente scan automatico del codice — non c'è filesystem |

La differenza è strutturale: il **command** legge il codice, scrive file, gira su `git`/`bash` — capacità che esistono solo in Claude Code. La **skill** è il cervello legale ed è portabile ovunque le Agent Skill siano supportate.

## Installazione — come plugin (Claude Code)

Il repo è già un marketplace Claude Code (`.claude-plugin/marketplace.json`). Da Claude Code:

```
/plugin marketplace add giorgiocerruti/ai-act-plugin
/plugin install ai-act-plugin@ai-act
```

Il primo comando registra il marketplace `ai-act` dal repo GitHub; il secondo installa il plugin. Per aggiornare: `/plugin marketplace update ai-act`.

Requisiti opzionali:
- MCP `clickup` — solo per `/ai-act docs --publish clickup`
- tool `Artifact` — solo per `/ai-act docs --publish artifact`

## Installazione — come skill autonoma (Claude, API, Agent SDK)

La skill `ai-act-check` è un'**Agent Skill** conforme (`SKILL.md` + `references/`) e si usa anche fuori dal plugin. Genera il pacchetto:

```bash
./scripts/build-skill.sh      # produce dist/ai-act-check.zip
```

Poi, a seconda della superficie:

- **App Claude (claude.ai / desktop)** — richiede un piano con code execution abilitato (Pro, Max, Team, Enterprise). *Impostazioni → Funzionalità → Skill → Carica una skill* e carica `dist/ai-act-check.zip`. Lo zip deve avere `SKILL.md` alla radice della cartella `ai-act-check/` (lo script lo garantisce). La skill resta **per singolo utente**: non c'è distribuzione a livello di team, ognuno la carica.
- **API Claude (Skills API)** — crea la skill dalla cartella (nessuno zip):
  ```python
  from anthropic.lib import files_from_dir
  skill = client.beta.skills.create(files=files_from_dir("skills/ai-act-check"))
  # poi passala nel container: {"skills": [{"type": "custom", "skill_id": skill.id, "version": "latest"}]}
  ```
  Scope: **intero workspace**.
- **Claude Code / Agent SDK (senza plugin)** — copia `skills/ai-act-check/` in `.claude/skills/` (di progetto) o `~/.claude/skills/` (personale): viene caricata dal filesystem, nessun upload.

Vincoli Agent Skill: `SKILL.md` alla radice, nome cartella = campo `name` (`ai-act-check`), max 30 MB non compressi (qui ~100 KB). Le skill **non si sincronizzano** tra app, API e Claude Code: ogni superficie va aggiornata a mano.

> La skill autonoma dà **solo** il triage legale conversazionale. Lo scan automatico del codice e della documentazione, gli artifact e il gate esistono solo nel plugin (serve un filesystem).

## Uso (plugin)

```bash
/ai-act scan                 # interroga, inventaria codice + documentazione, classifica, verifica la conformità
/ai-act check art.50         # domanda mirata su una norma: sei a norma o cosa manca? (non scrive file)
/ai-act rules                # emette .claude/rules/ai-act.md che gli agenti leggono durante lo sviluppo
/ai-act docs --client        # brief per il cliente: obblighi per parte, istruzioni art. 13, clausole
/ai-act docs --end-users     # informativa di trasparenza art. 50 per chi è esposto agli output
/ai-act report               # report HTML: problemi · non-problemi · correzioni
/ai-act gate                 # questo diff (codice o doc) aggiunge un componente IA o cambia la classe?
/ai-act status               # classificazione, conformità, staleness, ignoti, scadenze entro 180 giorni
```

Flag: `--client` / `--end-users` (solo `docs`) · `--publish clickup|artifact|both` (`docs` e `report`) · `--force-context` (ri-chiede il questionario di contesto).

Senza un primo token riconosciuto, l'intero argomento è trattato come domanda libera: carica la skill e risponde, senza scrivere file.

### Flusso tipico

1. `/ai-act scan` — la prima volta chiede i fatti non deducibili dal codice (ruolo, marchio, chi è esposto, stato del ciclo di vita) e li salva in `00-context.md`. Poi inventaria, classifica, scrive l'assessment.
2. `/ai-act rules` — genera i vincoli per gli agenti, con `globs` derivati dall'inventario (i vincoli si caricano dove vive il codice IA, non altrove).
3. `/ai-act docs --client` e `--end-users` — i due deliverable distinti · `/ai-act report` — il report HTML di conformità.
4. `/ai-act gate` prima di una PR, `/ai-act status` per una fotografia. `/ai-act check <norma>` per una domanda puntuale in qualsiasi momento.

## Come classifica (skill `ai-act-check`)

Le fasi, in ordine, senza scorciatoie:

1. **Interrogazione** — un vero interrogatorio di chi conosce il progetto: finalità, mercato, esposti, decisioni su persone, revisione umana, dati, ciclo di vita, contratti, modifiche previste. Il codice si legge; questi fatti si chiedono, mai si deducono.
2. **Divieti (art. 5)** — per primi, incluso il nuovo art. 5 §1-bis (esito vietato prevedibile e riproducibile senza misure di sicurezza ragionevoli). Se ricorre un divieto, la valutazione si ferma.
3. **Ruolo (art. 3, art. 25)** — non chi scrive il codice, ma con quale nome il sistema arriva sul mercato. Controllati i tre trasferimenti dell'art. 25 §1, la lett. c) esplicitamente.
4. **Classe di rischio (art. 6)** — condizioni cumulative del §1, Allegato III, deroghe del §3 con il knock-out sulla profilazione, art. 50. Componenti a finalità diverse classificati ciascuno per sé.
5. **Obblighi + scadenze** — da `references/scadenzario.md`, aggiornato dopo il Digital Omnibus.
6. **Verdetto di conformità** — per ogni obbligo: ✅ soddisfatto / ❌ no / ⚠️ incerto, con evidenza. Tre elenchi: problemi, non-problemi, correzioni. **Non basta classificare: dice se sei a norma.**
7. **Output** — struttura fissa.

## Artifact prodotti

Committati sotto `{{AI_ACT_DIR}}` (default `docs/compliance/ai-act/`):

| File | Contenuto | Owner |
|------|-----------|-------|
| `00-context.md` | Fatti non deducibili dal codice (ruolo, marchio, esposti, stato) | umano — mai riscritto |
| `01-inventory.md` | Componenti IA trovati, ognuno con `file:line` | auto |
| `02-assessment.md` | Divieti → ruolo → classe → obblighi → **conformità** | auto |
| `03-actions.md` | Azioni dev · azioni cliente · clausole | auto |
| `04-client-brief.md` | Deliverable per il cliente | auto |
| `05-end-user-notice.md` | Informativa art. 50 per gli end-user | auto |
| `06-report.html` | Report HTML: problemi · non-problemi · correzioni | auto |
| `99-state.json` | Hash, date, conformità, tracking staleness | auto |

Fuori dalla dir: `.claude/rules/ai-act.md` e `docs/wiki/concepts/ai-act.md`.

La dir è **committata**: un secondo run diffa contro il primo, e i "punti di attenzione futuri" diventano un controllo meccanico.

## Configurazione

Il command usa placeholder `{{...}}`. **Il plugin è autonomo: non ha un `/setup`.** Se un placeholder resta letterale a run time viene trattato come non impostato e chiesto via `AskUserQuestion`. Per fissare i default, sostituisci i valori direttamente in `commands/ai-act.md`. Elenco completo in [`CLAUDE.md`](./CLAUDE.md).

I più importanti:
- `{{AI_ACT_ORG_NAME}}` — chi immette il sistema sul mercato col proprio marchio. Decide la qualifica `provider` (art. 3 n. 3). **Mai inventarlo.**
- `{{AI_ACT_SCAN_PATHS}}` — i root del codice che l'inventario scansiona.
- `{{AI_ACT_DOC_PATHS}}` — i percorsi della documentazione di progetto scansionati (SCAN-2b).
- `{{AI_ACT_LEGAL_REVIEWER}}` — chi firma legalmente, stampato nel sign-off.

## Struttura

```
ai-act-plugin/
  .claude-plugin/
    plugin.json                # manifest del plugin
    marketplace.json           # marketplace per /plugin marketplace add
  CLAUDE.md                    # guida per chi lavora sul plugin
  README.md                    # questo file
  CHANGELOG.md                 # storico versioni + regole di versionamento
  commands/ai-act.md           # /ai-act (7 modi) — solo plugin Claude Code
  scripts/build-skill.sh       # impacchetta la skill autonoma → dist/ai-act-check.zip
  assets/report-template.html  # template del report HTML (modo report)
  tests/                       # fixture + run-signatures.sh (regressione firme)
  skills/ai-act-check/         # ← sorgente unica, condivisa dai due modi d'uso
    SKILL.md                   # le fasi (interrogazione → … → conformità → output)
    references/                # corpo normativo (11 file), unica fonte legale
```

Test: `./tests/run-signatures.sh` verifica che le firme rilevino i componenti attesi nelle fixture e che le parole di dominio da sole non ne inventino.

## Manutenzione e aggiornamenti

Il valore legale del plugin sta nelle `references/`, che sono l'**unica fonte normativa** che il command usa. La legge cambia (il Digital Omnibus ha già spostato le date una volta): quando succede, quei file vanno aggiornati, altrimenti ogni copia scaricata continua a citare norme superate.

- **Validità:** ogni file di `references/` porta la data dell'ultima revisione normativa in [`fonti-e-strumenti.md`](./skills/ai-act-check/references/fonti-e-strumenti.md). Ultima revisione: **19 agosto 2026**.
- **Ricevere gli aggiornamenti:** i clienti che hanno installato il plugin lo aggiornano con
  ```
  /plugin marketplace update ai-act
  ```
- **Contribuire un aggiornamento normativo:** correggi il file `references/` interessato, aggiorna la data di revisione, fai il bump di `version` in `plugin.json`, annota la modifica in [`CHANGELOG.md`](./CHANGELOG.md) citando l'atto UE/nazionale. Le regole di versionamento sono nel CHANGELOG.

Ogni deliverable esterno riporta comunque, nel blocco sign-off, la data di valutazione e il rimando al legale: la classificazione è una fotografia a una data, non una garanzia perpetua.

## Provenienza

Estratto da [`claude-infrastructure-template`](https://github.com/giorgiocerruti/claude-infrastructure-template) v2.26.0 (command `/ai-act` + skill `ai-act-check`) come plugin standalone.

## Licenza

MIT
