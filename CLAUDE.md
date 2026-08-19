# ai-act-plugin

Plugin Claude Code per la conformità all'**AI Act** — Reg. (UE) 2024/1689 come modificato dal Reg. (UE) 2026/1744 ("Digital Omnibus IA", in vigore dal 27 luglio 2026). Estratto dal `claude-infrastructure-template` come componente autonomo.

## Che cosa fa

Un command `/ai-act` guidato dalla skill `ai-act-check`. La skill è l'**autorità legale** (ogni affermazione normativa viene da lì e dalle sue `references/`, mai dalla memoria del modello né dal web). Il command aggiunge ciò che una skill non può fare: legge il codice con provenienza `file:line`, persiste i risultati, li rende per tre audience (agenti, cliente, end-user).

**Due modi d'uso da una sorgente unica (`skills/ai-act-check/`):** come **plugin Claude Code** (skill + command completo) o come **skill autonoma** caricata su Claude (app/API/Agent SDK) — solo il triage legale, niente scan del codice perché fuori da Claude Code non c'è filesystem. Il pacchetto per l'app si genera con `scripts/build-skill.sh` (→ `dist/ai-act-check.zip`). Dettagli e passi di upload nel README.

## Struttura

```
ai-act-plugin/
  .claude-plugin/
    plugin.json                  # manifest del plugin
    marketplace.json             # marketplace per /plugin marketplace add
  CLAUDE.md                      # questo file
  scripts/
    build-skill.sh               # impacchetta la skill autonoma → dist/ai-act-check.zip
  assets/
    report-template.html         # template del report HTML di conformità (modo report)
  tests/
    run-signatures.sh            # test di regressione sul rilevamento firme
    fixtures/                    # mini-repo campione + expected.json (oracolo)
  commands/
    ai-act.md                    # /ai-act — 7 modi: scan | check | rules | docs | report | gate | status (solo plugin)
  skills/
    ai-act-check/                # sorgente unica: serve sia il plugin sia la skill autonoma
      SKILL.md                   # fasi: interrogazione → divieti → ruolo → classe → obblighi → conformità → output
      references/                # corpo normativo (11 file), unica fonte legale
        scadenzario.md           # calendario consolidato post-Digital-Omnibus (leggere SEMPRE, mai a memoria)
        allegato-iii.md          # le 8 voci ad alto rischio
        divieti-art5.md          # pratiche vietate, incluso il nuovo art. 5 §1-bis
        trasparenza-art50.md     # obblighi di trasparenza, comma per comma
        obblighi-operatori.md    # chi fa cosa: fornitore, deployer, importatore, distributore
        tipologie-uso.md         # tassonomia delle componenti di IA
        modifiche-e-ruolo.md     # quando una modifica ti rende fornitore (art. 25, soglie GPAI)
        clausole-contrattuali.md # struttura dell'addendum contrattuale
        annessi-documentali.md   # Allegati IV–IX, XIII
        indice-articoli.md       # mappa 13 Capi / 113 articoli / 14 allegati
        fonti-e-strumenti.md     # quali fonti sono ufficiali e aggiornate
```

## Modi del command

| Modo | Cosa fa |
|------|---------|
| `scan` (o vuoto) | Interroga l'utente, inventaria codice **e documentazione** (SCAN-2b, rilievi `⚠️ NON VERIFICATO`), classifica con firme `strong`/`weak`, verifica la conformità (✅/❌/⚠️). Scrive `01`–`03`, aggiorna `99-state.json` |
| `check <norma>` | Domanda mirata su una singola norma (es. `check art.50`): chiede solo i fatti da cui dipende e risponde se sei a norma. Non scrive file |
| `rules` | Genera `.claude/rules/ai-act.md` (globs derivati dall'inventario) + `docs/wiki/concepts/ai-act.md` (se la wiki esiste) |
| `docs --client` | Brief per il cliente: obblighi per parte, istruzioni per l'uso art. 13, addendum contrattuale |
| `docs --end-users` | Informativa di trasparenza art. 50 per chi è esposto agli output |
| `report` | Report HTML di conformità (`06-report.html`): problemi · non-problemi · correzioni. `--publish artifact` per pubblicarlo |
| `gate [<ref>]` | Ri-triage di un diff (codice **e** doc): nuovo componente IA o cambio di finalità? Exit ≠ 0 su cambio classe |
| `status` | Classificazione, conformità, staleness (norme + assessment), ignoti, scadenze entro 180 giorni. Non scrive nulla |

## Artifact prodotti a runtime

Committati sotto `{{AI_ACT_DIR}}` (default `docs/compliance/ai-act/`): `00-context.md` (human-owned, mai riscritto), `01-inventory.md`, `02-assessment.md`, `03-actions.md`, `04-client-brief.md`, `05-end-user-notice.md`, `99-state.json`. Fuori dalla dir: `.claude/rules/ai-act.md` e `docs/wiki/concepts/ai-act.md`.

## Configurazione (placeholder)

Il command usa placeholder `{{...}}`. **Il plugin è autonomo: non ha un `/setup`.** Se un placeholder resta letterale a run time il command lo tratta come non impostato e lo chiede via `AskUserQuestion`, scrivendo la risposta in `00-context.md`. Per fissare i default, sostituisci i valori direttamente in `commands/ai-act.md`.

| Placeholder | Significato | Default |
|-------------|-------------|---------|
| `{{AI_ACT_DIR}}` | Dove vivono gli artifact | `docs/compliance/ai-act` |
| `{{AI_ACT_ORG_NAME}}` | Chi immette il sistema sul mercato col proprio marchio — decide la qualifica `provider` (art. 3 n. 3). **Mai inventarlo** | — |
| `{{AI_ACT_DEFAULT_ROLE}}` | Ruolo preselezionato: `provider` \| `deployer` \| `component-supplier` \| `unknown` | `unknown` |
| `{{AI_ACT_CLIENT_NAME}}` | Destinatario dei deliverable | vuoto (prodotti interni) |
| `{{AI_ACT_SCAN_PATHS}}` | Root del codice scansionati dall'inventario | repo root |
| `{{AI_ACT_DOC_PATHS}}` | Percorsi della documentazione scansionati da SCAN-2b | `README* docs/ doc/ specs/ *.md` |
| `{{AI_ACT_EXTRA_SIGNATURES}}` | Firme ERE extra per librerie AI stack-specific | vuoto |
| `{{AI_ACT_OUTPUT_LANG}}` | Lingua dei documenti generati | `Italiano` |
| `{{AI_ACT_LEGAL_REVIEWER}}` | Chi firma legalmente (blocco sign-off) | — |
| `{{CLICKUP_COMPLIANCE_DOC_ID}}` | ClickUp Doc per `--publish clickup` | — |
| `{{INDUSTRY_SECTOR}}` | Settore, per il cross-check Allegato III | — |

## Dipendenze verso il template (opzionali, degradano da sole)

Il command richiama sistemi che esistevano nel template originale. **Senza di essi funziona lo stesso** — sono invocati con la clausola "se presente":

- `docs-policy` — ownership della pagina wiki (`## Business 🔒` mai sovrascritta)
- `gotchas` skill + `docs/wiki/gotchas-inbox.jsonl` — log degli errori ricorrenti
- `/wiki` + `docs/wiki/` — index, log, `lint-semantic.sh`
- `/create` — invoca `gate` quando la task menziona un componente IA
- `hooks/pipeline-validate.sh` — **esplicitamente NON toccato** dal gate

Dipendenze runtime esterne: MCP `mcp__clickup__*` (solo `docs --publish clickup`) e tool `Artifact` (solo `docs --publish artifact`).

## Principi da tenere fermi

- **La classificazione dipende dalla finalità, non dalla tecnologia.** Non classificare "un LLM": classifica un sistema con una destinazione d'uso.
- **Nessun fatto senza provenienza.** Fatti dal codice → `file:line`. Fatti dall'umano → `00-context.md`, mai dedotti dal repo. Ignoto → `⚠️ NON VERIFICATO` con impatto nei due scenari.
- **Obbligo vs prudenza.** Ogni azione taggata `[OBBLIGO art. X]` o `[PRUDENZA]`.
- **Scadenze solo da `references/scadenzario.md`** — il Digital Omnibus ha spostato le date.
- **Non è un parere legale.** Ogni deliverable esterno chiude col blocco sign-off che nomina `{{AI_ACT_LEGAL_REVIEWER}}`.

## Provenienza

Estratto da `claude-infrastructure-template` v2.26.0 (command `/ai-act` + skill `ai-act-check`). La copia nel template resta attiva; questo plugin è la versione standalone.
