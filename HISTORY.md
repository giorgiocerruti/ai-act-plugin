# Storico — genesi del plugin

Riassunto della sessione in cui `ai-act-plugin` è stato estratto dal template. Punto di partenza per chi riprende il lavoro da qui.

**Data:** 2026-08-19
**Origine:** `claude-infrastructure-template` v2.26.0
**Autore sessione:** Giorgio Cerruti

---

## Obiettivo

Estrarre la funzionalità AI Act del template in un **plugin Claude Code autonomo e separato**.

## Decisioni prese

1. **Copia, non spostamento.** Il template mantiene attivo `/ai-act`; questo plugin è la versione standalone. Due copie da riallineare a mano se una delle due cambia.
2. **Layout plugin standard:** `.claude-plugin/plugin.json` + `commands/` + `skills/`.
3. **`plugin.json` con identità propria:** `name: ai-act-plugin`, `version: 1.0.0` (ripartito da 1.0.0, non ereditato dal 2.26.0 del template). Keyword ridotte al solo dominio AI Act.
4. **Nessun `/setup`.** Il plugin è autonomo: i placeholder `{{...}}` non vengono riempiti da un setup, il command li chiede a run time via `AskUserQuestion` (o si fissano a mano in `commands/ai-act.md`).

## Componenti estratti

Individuati nel template in 2 posti principali:

- `commands/ai-act.md` (450 righe) — command `/ai-act`, 5 modi: `scan | rules | docs | gate | status`. Legge il codice, persiste artifact, rende per 3 audience (agenti, cliente, end-user).
- `skills/ai-act-check/` — autorità legale:
  - `SKILL.md` (109 righe) — 6 fasi: fatti → divieti → ruolo → classe rischio → obblighi → output.
  - `references/` — 11 file, corpo normativo (unica fonte legale): `scadenzario`, `allegato-iii`, `divieti-art5`, `trasparenza-art50`, `obblighi-operatori`, `tipologie-uso`, `modifiche-e-ruolo`, `clausole-contrattuali`, `annessi-documentali`, `indice-articoli`, `fonti-e-strumenti`.

Divisione: la skill fa tutto il legale (mai da memoria/web); il command fa ciò che una skill non può — legge codice con `file:line`, persiste in `docs/compliance/ai-act/`, rende per le tre audience.

## File creati in questa sessione

- `.claude-plugin/plugin.json` — manifest (JSON validato con `jq`).
- `CLAUDE.md` — guida per chi lavora sul plugin (struttura, modi, artifact, placeholder, soft-dep, principi).
- `README.md` — guida user-facing (install, uso, 6 fasi, artifact, config).
- `HISTORY.md` — questo file.

## Accoppiamenti col template (soft, degradano da soli)

Il command richiama sistemi del template originale, tutti con clausola "se presente" — senza di essi funziona lo stesso:

- `docs-policy` — ownership pagina wiki (`## Business 🔒` mai sovrascritta)
- `gotchas` skill + `docs/wiki/gotchas-inbox.jsonl`
- `/wiki` + `docs/wiki/` (index, log, `lint-semantic.sh`)
- `/create` — invoca `gate` quando la task menziona un componente IA
- `hooks/pipeline-validate.sh` — esplicitamente NON toccato dal gate

Dipendenze runtime esterne: MCP `mcp__clickup__*` (`docs --publish clickup`), tool `Artifact` (`docs --publish artifact`).

## Placeholder da configurare (nessun setup automatico)

`AI_ACT_DIR` · `AI_ACT_ORG_NAME` · `AI_ACT_DEFAULT_ROLE` · `AI_ACT_CLIENT_NAME` · `AI_ACT_SCAN_PATHS` · `AI_ACT_EXTRA_SIGNATURES` · `AI_ACT_OUTPUT_LANG` · `AI_ACT_LEGAL_REVIEWER` · `CLICKUP_COMPLIANCE_DOC_ID` · `INDUSTRY_SECTOR` (+ eredita `STACK_1_SRC`/`STACK_2_SRC` dallo scan-paths default del template).

Il più critico: `AI_ACT_ORG_NAME` — decide la qualifica `provider` (art. 3 n. 3), **mai inventarlo**.

## TODO aperti / prossimi passi

- [ ] `git init` — la cartella non è ancora un repo git.
- [ ] Decidere se sganciare i soft-ref al template (docs-policy, wiki, gotchas, /create) o tenerli opzionali.
- [ ] Fissare i default dei placeholder in `commands/ai-act.md`, oppure aggiungere un `/setup` proprio del plugin.
- [ ] Valutare un marketplace / repo remoto (`repository` in plugin.json punta a `github.com/giorgiocerruti/ai-act-plugin`, ancora da creare).
- [ ] Testare `/ai-act scan` su un progetto reale con componenti IA.

## Stato finale della cartella

```
ai-act-plugin/
  .claude-plugin/plugin.json
  CLAUDE.md
  README.md
  HISTORY.md
  commands/ai-act.md
  skills/ai-act-check/
    SKILL.md
    references/ (11 file)
```
