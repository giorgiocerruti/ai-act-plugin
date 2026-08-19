---
allowed-tools: Read, Write, Edit, Glob, Grep, Bash(mkdir:*), Bash(test:*), Bash(ls:*), Bash(git:*), Bash(grep:*), Bash(rg:*), Bash(jq:*), Bash(date:*), Bash(shasum:*), Bash(wc:*), Bash(sed:*), Agent, AskUserQuestion, WebSearch, WebFetch, Artifact, TodoWrite
argument-hint: <scan|rules|docs|gate|status> [--client | --end-users] [--publish clickup|artifact|both] [--force-context]
description: AI Act compliance for this project (Reg. UE 2024/1689 as amended by Reg. UE 2026/1744). Scans the code for AI components, classifies risk and role, lists obligations with deadlines, generates rules the agents must follow, and produces client-facing documents. Always loads the ai-act-check skill.
---

# /ai-act — AI Act triage, rules and deliverables

## User Input
$ARGUMENTS

---

## CONFIGURATION

| Placeholder | Meaning |
|-------------|---------|
| `{{AI_ACT_DIR}}` | Where the compliance artifacts live. Default `docs/compliance/ai-act` |
| `{{AI_ACT_ORG_NAME}}` | Legal name of the entity that puts the system on the market **under its own name or trademark**. This — not who writes the code — decides the `provider` qualification (art. 3 n. 3) |
| `{{AI_ACT_DEFAULT_ROLE}}` | Pre-selected role in the context questionnaire: `provider` \| `deployer` \| `component-supplier` \| `unknown`. Only a default — every run confirms it |
| `{{AI_ACT_CLIENT_NAME}}` | Client / principal the deliverables are addressed to. Empty for internal products |
| `{{AI_ACT_SCAN_PATHS}}` | Space-separated roots the inventory scans. Default: the repository root (`.`) |
| `{{AI_ACT_EXTRA_SIGNATURES}}` | Extra `ERE` alternatives for stack-specific AI libraries, appended to the built-in signature set. Empty is fine |
| `{{AI_ACT_OUTPUT_LANG}}` | Language of every generated document. Default `Italiano` |
| `{{AI_ACT_LEGAL_REVIEWER}}` | Who signs off legally. Printed in the sign-off block of every external deliverable |
| `{{CLICKUP_COMPLIANCE_DOC_ID}}` | ClickUp Doc that receives the published deliverables (`--publish clickup`) |
| `{{INDUSTRY_SECTOR}}` | Sector of the project — feeds the Annex III cross-check |

If a placeholder is still literal (`{{...}}`) at run time, treat it as **unset**: ask for the value with `AskUserQuestion` and write the answer into `00-context.md`. Never guess it, and never invent `{{AI_ACT_ORG_NAME}}` — it is the single fact that most changes the outcome.

---

## MANDATORY RULES

### 1. The skill is the authority
Load the **`ai-act-check`** skill before any classification, and follow its phases in order (facts → prohibitions → role → risk class → obligations → output). This command adds only what a skill cannot do: it reads the code, persists the results, and renders them for three audiences. **Every legal statement comes from the skill and its `references/`** — never from your own memory of the regulation, and never from a web search unless the skill's `references/fonti-e-strumenti.md` names that source as official.

### 2. No fact without provenance
Two kinds of facts, never mixed:
- **Facts from the code** — every entry in the inventory carries `file:line`. If you did not read it, it does not go in. Same rule as `docs-policy`: a plausible invention is worse than a gap because nobody re-checks it.
- **Facts from the human** — role, trademark, who is exposed to the output, deployment status. These live in `00-context.md`, are **human-owned**, and are never overwritten or inferred from the repo name.

Anything unknown is written as `⚠️ NON VERIFICATO — <what is missing>` plus **how the assessment would change in both scenarios** (skill, Fase 1).

### 3. Obligatory vs prudent
Every action is tagged `[OBBLIGO art. X]` or `[PRUDENZA]`. Confusing the two makes the client spend where nothing is required and costs credibility. Sanctions are cited only where pertinent, with the correct ceiling (skill, "Non allarmare").

### 4. Not legal advice
Every artifact and every external deliverable ends with the sign-off block (see *Sign-off block* below), naming `{{AI_ACT_LEGAL_REVIEWER}}`. Perimeter decisions and contract clauses are validated by a lawyer.

### 5. Deliverables are not interchangeable
The document for `{{AI_ACT_CLIENT_NAME}}` (obligations, instructions for use art. 13, contract addendum) and the notice for **their end users** (art. 50 disclosure, generated-content labelling) have different audiences, different content and different legal bases. Never merge them into one file.

### 6. Rules generated for agents carry their validity
`.claude/rules/ai-act.md` is read blindly by every agent. If the classification behind it is wrong, the error propagates to every feature. The generated file therefore carries `context_hash` + `generated_at`, and `/ai-act gate` marks it **STALE** as soon as the context or the inventory changes.

### 7. Wiki ownership
`docs/wiki/concepts/ai-act.md` follows `docs-policy`: `## Business (human-owned 🔒)` is **never** overwritten; only `## Implementazione (auto-derived 🔄)` is regenerated. Divergences go under `## Drift / Open questions`.

---

## ARTIFACT LAYOUT

```
{{AI_ACT_DIR}}/
  00-context.md        human-owned facts (role, trademark, users, deployment) — asked once, reused
  01-inventory.md      AI components found in the code, each with file:line — regenerated every scan
  02-assessment.md     prohibitions → role → risk class → obligations with deadlines
  03-actions.md        actions for the dev team · actions for the client · contract clauses
  04-client-brief.md   deliverable for {{AI_ACT_CLIENT_NAME}}  (mode docs --client)
  05-end-user-notice.md deliverable for the client's end users (mode docs --end-users)
  99-state.json        hashes, run dates, staleness tracking
```

Generated outside the directory:
- `.claude/rules/ai-act.md` — constraints the agents read during `/create` (mode `rules`)
- `docs/wiki/concepts/ai-act.md` — agent-readable wiki page (mode `rules`)

The directory is **committed**. That is the point: a second run diffs against the first, and the skill's "punti di attenzione futuri" (what would change the risk class) stops being a reminder and becomes a mechanical check.

### `99-state.json` schema

```json
{
  "schema": 1,
  "last_run": { "scan": "2026-08-04", "rules": null, "docs": null, "gate": null },
  "context_hash": "<sha1 of 00-context.md>",
  "inventory_hash": "<sha1 of 01-inventory.md>",
  "classification": { "risk_class": "alto-rischio|rischio-limitato|fuori-perimetro|vietato|indeterminato",
                      "role": "provider|deployer|component-supplier|unknown",
                      "annex_iii_item": null,
                      "art6_3_derogation_claimed": false },
  "unknowns": ["…"],
  "rules_generated_from": { "context_hash": "…", "inventory_hash": "…" },
  "published": { "clickup_doc_id": null, "artifact_url": null }
}
```

---

## MODE ROUTING

First token of `$ARGUMENTS`:

| Token | What it does | Requires |
|-------|--------------|----------|
| `scan` (or empty) | Inventory the code, classify, list obligations, write `01`–`03`, print the summary | — |
| `rules` | Generate `.claude/rules/ai-act.md` + the wiki page from the assessment | `02-assessment.md` |
| `docs --client` | Client-facing brief: obligations split by party, instructions for use (art. 13), contract addendum | `02-assessment.md`, `03-actions.md` |
| `docs --end-users` | Transparency notice for the end users (art. 50): chatbot disclosure, generated-content labelling | `02-assessment.md` |
| `gate [<ref>]` | Re-triage a diff: does this change add an AI component or alter the intended purpose? Exit non-zero on a class change | `99-state.json` |
| `status` | Print classification, staleness, unknowns, deadlines within 180 days. Changes nothing | `99-state.json` |

`--publish clickup|artifact|both` applies to `docs` only. `--force-context` re-asks the context questionnaire even if `00-context.md` exists.

If the first token is none of the above, treat the whole `$ARGUMENTS` as a free-form question, load the skill and answer it — writing nothing.

---

## PHASE 0 — Bootstrap (every mode)

```bash
mkdir -p "{{AI_ACT_DIR}}"
test -f "{{AI_ACT_DIR}}/99-state.json" || printf '{"schema":1,"last_run":{},"classification":{"risk_class":"indeterminato","role":"unknown"},"unknowns":[]}\n' > "{{AI_ACT_DIR}}/99-state.json"
```

Read, in this order: `99-state.json`, `00-context.md` (if present), `docs/wiki/gotchas.md` (if present). Then load the `ai-act-check` skill.

---

## MODE `scan`

### SCAN-1 — Context (human-owned facts)

If `00-context.md` exists and `--force-context` was not passed, **read it and skip to SCAN-2**. Print one line: `Contesto: riuso {{AI_ACT_DIR}}/00-context.md del <data>`.

Otherwise collect the facts of the skill's Fase 1 with `AskUserQuestion` — grouped, never one question per fact:

1. **Ruolo e marchio** — with which name does the system reach the market, and who puts it into service? Options built from `{{AI_ACT_ORG_NAME}}` / `{{AI_ACT_CLIENT_NAME}}` / *terzo fornitore di componenti* / *non lo so ancora*.
2. **Esposti agli output** — internal staff · the client's business customers · consumers · the general public · minors (multiSelect).
3. **Decisioni su persone fisiche** — none · supports a human decision · decides autonomously; and in which area (lavoro/HR, credito, assicurazioni, istruzione, salute, servizi pubblici essenziali, giustizia, migrazione, biometria, nessuna).
4. **Stato** — idea · demo su dati fittizi · sviluppo · prova in condizioni reali · produzione.

The distinction *demo su dati fittizi* vs *prova in condizioni reali* is not cosmetic: art. 2 §8 covers the first and **not** the second.

Write `00-context.md`:

```markdown
---
type: ai-act-context
owner: human
updated: <YYYY-MM-DD>
org_name: "<{{AI_ACT_ORG_NAME}}>"
client_name: "<{{AI_ACT_CLIENT_NAME}}>"
role_declared: provider|deployer|component-supplier|unknown
market_name: "<trademark the system ships under>"
lifecycle: idea|demo|sviluppo|prova-reale|produzione
sector: "{{INDUSTRY_SECTOR}}"
---

# Contesto — fatti non deducibili dal codice

> Sezione human-owned. Nessun agente la riscrive. Correggila a mano quando cambia
> il perimetro: da questi fatti dipendono ruolo (art. 25) e classe di rischio.

## Che cosa fa il sistema
<one sentence>

## Chi lo immette sul mercato e con quale nome
…

## Chi è esposto agli output
…

## Decisioni su persone fisiche
…

## Stato del ciclo di vita
…

## Ignoto
- <fact> — impatto se A: … / se B: …
```

### SCAN-2 — Inventory from the code

Scan `{{AI_ACT_SCAN_PATHS}}` (fall back to the repo root if unset). Use `Grep`/`rg`; for anything ambiguous, dispatch the `Explore` agent to trace how the component is actually used — a dependency in `package.json` that nothing imports is not an AI component of the system.

Signature set (extend with `{{AI_ACT_EXTRA_SIGNATURES}}`):

| Class | Signatures (case-insensitive) |
|-------|-------------------------------|
| Modelli generativi / GPAI | `anthropic`, `@anthropic-ai`, `claude-`, `openai`, `gpt-4`, `gpt-5`, `mistral`, `cohere`, `gemini`, `genai`, `ollama`, `llama`, `bedrock`, `azure.*openai` |
| Orchestrazione LLM | `langchain`, `llamaindex`, `semantic-kernel`, `haystack`, `crewai`, `autogen`, `mcp` |
| Embedding / RAG | `embedding`, `pgvector`, `pinecone`, `qdrant`, `weaviate`, `chroma`, `faiss`, `vector_store` |
| ML classico / scoring | `sklearn`, `scikit`, `xgboost`, `lightgbm`, `tensorflow`, `torch`, `onnx`, `predict\(`, `\.score\(`, `risk_score`, `scoring` |
| Biometria / visione | `face`, `facial`, `fingerprint`, `iris`, `mediapipe`, `opencv`, `deepface`, `insightface`, `emotion` |
| Voce / audio | `whisper`, `speech_to_text`, `tts`, `voice_clone`, `elevenlabs` |
| Contenuti sintetici (art. 50) | `image_gen`, `stable-diffusion`, `dall-e`, `midjourney`, `deepfake`, `avatar` |
| Domini ad alto rischio (Allegato III) | `candidat`, `cv_`, `resume`, `hiring`, `recruit`, `performance_review`, `credit`, `creditworthiness`, `insurance`, `premium`, `student`, `exam`, `grading`, `triage`, `diagnos`, `welfare`, `benefit` |
| Dati art. 9 GDPR | `health`, `biometric`, `ethnic`, `religio`, `political`, `union_member`, `sexual`, `criminal` |

For each hit that survives the *is it really used* check, produce one inventory row. Then write `01-inventory.md`:

```markdown
---
type: ai-act-inventory
owner: auto
generated: <YYYY-MM-DD>
scan_paths: "{{AI_ACT_SCAN_PATHS}}"
components_found: <N>
---

# Inventario dei componenti di IA

## Componenti

### C1 — <nome>
- **Tassonomia**: <voce di references/tipologie-uso.md>
- **Evidenza**: `path/to/file.ts:42`, `path/to/other.py:118`
- **Modello / fornitore a monte**: <nome> — `path:line` · oppure ⚠️ NON VERIFICATO
- **Finalità prevista**: <what it is for, in the product — not what the library can do>
- **Output verso**: <chi legge l'output>
- **Revisione umana**: presente `path:line` · assente · ⚠️ NON VERIFICATO
- **Dati trattati**: <campi> — art. 9 GDPR: sì/no

## Segnali di dominio rilevati
| Segnale | Dove | Perché rileva |
|---------|------|---------------|

## Non verificato
- ⚠️ …
```

**The human-review field is the most valuable line in the file.** Per the skill, a mandatory hold point before the output drops obligations (art. 50 §4), attenuates classification (art. 6 §3 lett. c) and reduces contractual exposure. Look for it in the code — an approval flag, a `status: pending_review`, a manual publish step — and record where it is or that it is missing.

### SCAN-3 — Triage

Run the skill's Fase 2 → Fase 5 on `00-context.md` + `01-inventory.md`. In order, no shortcuts:

1. **Prohibitions (art. 5)** — including the new art. 5 §1-bis mechanism: a generative component whose prohibited output is *reasonably foreseeable and reproducible without significant technical modification*, with no reasonable safeguards in place, is caught. An image generator on unfiltered prompts is exactly this case. If a prohibition applies, **stop**: write `02-assessment.md` with the prohibition, skip the obligation table, and say plainly that the system cannot be built in that form.
2. **Role** — art. 3 n. 3 / n. 4, plus the three art. 25 §1 transfers. Check lett. c) explicitly (a change of intended purpose that turns a non-high-risk — even general-purpose — system into a high-risk one): it is the one that catches integrators.
3. **Risk class** — art. 6 §1 (the two conditions are **cumulative**), art. 6 §2 + Annex III, art. 6 §3 derogations with the **profiling knock-out**, art. 50, out of scope + art. 2 exclusions.
4. **Obligations + deadlines** — from `references/scadenzario.md`, **never from memory**: the Digital Omnibus moved the dates. Split provider obligations from deployer obligations. Remember art. 4 (AI literacy) applies regardless of risk class since 2 February 2025.

Write `02-assessment.md` (frontmatter + the skill's Fase 6 sections 1–5 and 9–10) and `03-actions.md` (sections 6–8):

```markdown
---
type: ai-act-assessment
owner: auto
generated: <YYYY-MM-DD>
context_hash: <sha1>
inventory_hash: <sha1>
risk_class: <…>
role: <…>
annex_iii_item: <voce o null>
art6_3_derogation_claimed: true|false
unknowns: <N>
---
```

The **Punti di attenzione futuri** section is mandatory and concrete: which change to which component would move the class. Write it as a list of conditions an agent can check, because `/ai-act gate` will check them.

### SCAN-4 — State + summary

Update `99-state.json` (hashes via `shasum`, classification, unknowns). Then print, in `{{AI_ACT_OUTPUT_LANG}}`:

```
## Esito
<classe> · <ruolo> · <azione urgente: sì|no>

## Componenti IA: N        Ignoti: M
## Obblighi con scadenza entro 180 giorni
| obbligo | art. | chi | scadenza | azione |

## Prossimi passi
/ai-act rules   → vincoli per gli agenti
/ai-act docs --client / --end-users
```

Then append one line per recurring compliance mistake caught to `docs/wiki/gotchas-inbox.jsonl` (see the `gotchas` skill), if that file exists.

---

## MODE `rules`

Requires `02-assessment.md`. If its `context_hash` no longer matches `00-context.md`, refuse and tell the user to re-run `scan` — generating rules from a stale assessment is the failure mode rule 6 exists to prevent.

### RULES-1 — `.claude/rules/ai-act.md`

`globs` are **derived from the inventory**, not blanket `**/*`: the union of the directories holding the components in `01-inventory.md`. Scoped rules get read where they matter and ignored where they do not.

```markdown
---
globs: "<derived from 01-inventory.md>"
---

# AI Act — vincoli operativi

> Generato da `/ai-act rules` il <data> da `{{AI_ACT_DIR}}/02-assessment.md`.
> context_hash: <…> · inventory_hash: <…>
> **Se il contesto o l'inventario cambiano queste regole sono STALE**: rilancia `/ai-act scan`.
> Classificazione corrente: <classe> · ruolo: <ruolo>.

## Vincoli non negoziabili [OBBLIGO]
- <one line per obligation that constrains code, with the article>

## Cosa fa cambiare classe di rischio
- <condition> → <new class> → **fermati e chiedi**, non implementare

## Da fare in ogni feature che tocca un componente IA
- <e.g. logging art. 12, human review, art. 50 disclosure in the UI>

## Buone prassi [PRUDENZA]
- <not required, recommended>
```

The **"cosa fa cambiare classe"** section is the one that earns its keep: it turns the assessment's static photograph into a stop condition an agent hits *before* writing the code.

### RULES-2 — `docs/wiki/concepts/ai-act.md` (only if a wiki already exists)

**Skip this step entirely unless `docs/wiki/` already exists.** This plugin is standalone: a project that never adopted the template wiki must not have `docs/wiki/` conjured into it. If the directory is absent, note `wiki: assente — passo saltato` in the RULES-3 report and move on.

If `docs/wiki/` exists, follow `docs-policy`. If the page exists, **preserve `## Business (human-owned 🔒)` verbatim** and regenerate only `## Implementazione (auto-derived 🔄)`. Cite `code:<path>#<symbol>` inside the sections, not only in the frontmatter, and mark anything unread as `⚠️ NON VERIFICATO`.

Then update `docs/wiki/index.md` and append to `docs/wiki/log.md` as `/wiki` does, and run `docs/wiki/lint-semantic.sh` if present.

### RULES-3 — Report
List the generated files, the derived `globs`, and how many constraints were emitted per category.

---

## MODE `docs`

Requires `02-assessment.md` + `03-actions.md`. Written in `{{AI_ACT_OUTPUT_LANG}}`. Two distinct deliverables (rule 5).

### `--client` → `04-client-brief.md`

For `{{AI_ACT_CLIENT_NAME}}`. Sections:

1. **In tre righe** — what they have, which class, whether something is urgent.
2. **Perché li riguarda** — the role split: what falls on `{{AI_ACT_ORG_NAME}}` as provider/supplier and what falls on them as deployer. Say explicitly **what cannot be discharged on their behalf** (skill, Fase 6 §7) — e.g. the art. 26 §7 information to workers, the art. 4 literacy of their own staff.
3. **Obblighi** — table: obbligo · articolo · chi · scadenza · cosa fare concretamente. Each tagged `[OBBLIGO]` / `[PRUDENZA]`.
4. **Istruzioni per l'uso (art. 13)** — only for high-risk systems: intended purpose, known limits, human oversight required, expected accuracy, foreseeable misuse. This is a **provider obligation**: if the role is provider, this section is not optional.
5. **Cosa fa cambiare le carte in tavola** — the changes that would reclassify the system.
6. **Clausole contrattuali** — from `references/clausole-contrattuali.md`; if the role is *component supplier* into a high-risk host system, the art. 25 §4 written agreement is listed first.
7. **Aree adiacenti** — GDPR, Statuto dei lavoratori, Codice del consumo, MDR where they intersect. Often the concrete risk lives here.
8. **Sign-off block.**

### `--end-users` → `05-end-user-notice.md`

For the people exposed to the outputs — plain language, no article numbers in the body (they go in a footnote), ready to be pasted into a site, an app or a T&C annex. Include **only what art. 50 actually requires** for the components in the inventory:

- direct interaction with an AI system → disclosure at first interaction, unless obvious to a reasonably informed person;
- synthetic audio/image/video/text → machine-readable marking of generated content;
- deepfake → declared as artificially generated, with the art. 50 §4 editorial exception where a human holds editorial responsibility;
- emotion recognition / biometric categorisation → information to the exposed person.

If none applies, say so in one line and do **not** manufacture a notice: an unnecessary disclosure trains users to ignore the necessary ones.

### Publishing

- `--publish clickup` → `mcp__clickup__clickup_create_document` / `clickup_create_document_page` under `{{CLICKUP_COMPLIANCE_DOC_ID}}`, one page per deliverable. Record the Doc ID in `99-state.json`.
- `--publish artifact` → an HTML page via the `Artifact` tool, for the deliverable the client actually reads. **Ask before publishing** (an artifact URL is shareable), never impersonate the client's branding, and keep the sign-off block visible on the page.
- `--publish both` → both, with the same confirmation.
- No flag → files only.

### Sign-off block (mandatory, every external deliverable)

```markdown
---
**Nota** — Documento tecnico di supporto, non parere legale. Le decisioni di perimetro,
la classificazione e le clausole contrattuali vanno validate da {{AI_ACT_LEGAL_REVIEWER}}.
Basato sul Reg. (UE) 2024/1689 come modificato dal Reg. (UE) 2026/1744.
Valutazione al <data>, su un sistema nello stato: <lifecycle>. Elementi non verificati: <N>.
```

---

## MODE `gate`

The bridge to the development pipeline. Runs on a diff — `git diff <ref>...HEAD --name-only` with `<ref>` defaulting to the merge base with the main branch.

1. Load `99-state.json`. No prior scan → print `AI-ACT: no baseline` and exit 0 (never block a project that never ran the triage).
2. Re-run the SCAN-2 signature set **on the changed files only**.
3. Verdicts:

| Condition | Verdict |
|-----------|---------|
| No AI signature in the diff | `PASS` |
| AI signature in files already in `01-inventory.md`, purpose unchanged | `PASS` (note it) |
| New AI component not in the inventory | `STALE` — run `/ai-act scan` |
| The diff matches a condition in *Punti di attenzione futuri* | `RECLASSIFY` — stop, human decision required |
| A signature hits a prohibited practice (art. 5) | `BLOCK` — never automatic, escalate to the user |
| `context_hash` ≠ hash of `00-context.md` | `STALE` |

4. Print the verdict, the evidence `file:line` and the exact next command. `RECLASSIFY` and `BLOCK` exit non-zero.

**This gate does not touch `hooks/pipeline-validate.sh`.** It is invoked explicitly — from `/create` when the task description mentions an AI component, or manually before a PR. Wiring it into the hook is a separate decision, taken once the classification is stable.

---

## MODE `status`

Reads `99-state.json` and the artifacts, writes nothing:

```
Classe: <…>   Ruolo: <…>   Ultimo scan: <data>
Regole agenti: aggiornate | STALE (context_hash difforme) | mai generate
Componenti IA: N          Elementi non verificati: M
Scadenze nei prossimi 180 giorni:
  <data> — <obbligo> (art. X) — <chi>
Deliverable: 04-client-brief.md <data> · 05-end-user-notice.md <mai>
```

---

## FAILURE MODES TO AVOID

- **Classifying a technology instead of a system.** "Usiamo un LLM" is not a classification. The same model is out of scope in a document assistant and high-risk in a CV screener. Always classify *a component with an intended purpose*, taken from `00-context.md`.
- **Inferring the role from who writes the code.** It comes from whose name is on the market. If `00-context.md` says `unknown`, the assessment says `indeterminato` and shows both branches — it does not pick the comfortable one.
- **Claiming an art. 6 §3 derogation for free.** It must be documented before placing on the market and still requires EU database registration (art. 6 §4, art. 49 §2), and it is unavailable outright if the system profiles natural persons.
- **Quoting the 2024 calendar.** The Digital Omnibus moved the dates. Always read `references/scadenzario.md`.
- **Producing a notice nobody needs.** See `docs --end-users`.
- **Letting `rules` outlive its assessment.** That is what `context_hash` is for.

---

## CHECKLIST

- [ ] `ai-act-check` skill loaded before any classification
- [ ] `00-context.md` present and human-confirmed (not inferred)
- [ ] Inventory rows all carry `file:line`; unused dependencies excluded
- [ ] Human-review presence recorded for every component
- [ ] Prohibitions (art. 5) checked **first**, art. 5 §1-bis included
- [ ] Role determined with the art. 25 transfers checked, lett. c) explicitly
- [ ] Risk class derived in the skill's order; profiling knock-out applied
- [ ] Deadlines taken from `references/scadenzario.md`, not from memory
- [ ] Every action tagged `[OBBLIGO art. X]` or `[PRUDENZA]`
- [ ] Unknowns listed with both-scenario impact
- [ ] `99-state.json` updated with fresh hashes
- [ ] Generated rules carry `context_hash` and the stale warning
- [ ] Wiki `## Business (human-owned 🔒)` untouched
- [ ] Sign-off block on every external deliverable
- [ ] Publishing to ClickUp/Artifact confirmed by the user before it happens

---

## START EXECUTION

Parse the mode from `$ARGUMENTS`, run PHASE 0, load the `ai-act-check` skill, then execute the mode.
