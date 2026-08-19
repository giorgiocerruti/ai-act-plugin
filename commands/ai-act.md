---
allowed-tools: Read, Write, Edit, Glob, Grep, Bash(mkdir:*), Bash(test:*), Bash(ls:*), Bash(git:*), Bash(grep:*), Bash(rg:*), Bash(jq:*), Bash(date:*), Bash(shasum:*), Bash(wc:*), Bash(sed:*), Agent, AskUserQuestion, WebSearch, WebFetch, Artifact, TodoWrite
argument-hint: <scan|rules|docs|gate|status> [--client | --end-users] [--publish clickup|artifact|both] [--force-context]
description: Conformità all'AI Act per questo progetto (Reg. UE 2024/1689 come modificato dal Reg. UE 2026/1744). Scansiona il codice per componenti di IA, classifica rischio e ruolo, elenca gli obblighi con le scadenze, genera le regole che gli agenti devono seguire e produce i documenti destinati al cliente. Carica sempre la skill ai-act-check.
---

# /ai-act — triage AI Act, regole e deliverable

## User Input
$ARGUMENTS

---

## CONFIGURAZIONE

| Placeholder | Significato |
|-------------|-------------|
| `{{AI_ACT_DIR}}` | Dove vivono gli artifact di conformità. Default `docs/compliance/ai-act` |
| `{{AI_ACT_ORG_NAME}}` | Denominazione legale del soggetto che immette il sistema sul mercato **con il proprio nome o marchio**. È questo — non chi scrive il codice — a determinare la qualifica di `provider` (art. 3 n. 3) |
| `{{AI_ACT_DEFAULT_ROLE}}` | Ruolo preselezionato nel questionario di contesto: `provider` \| `deployer` \| `component-supplier` \| `unknown`. Solo un default — ogni esecuzione lo conferma |
| `{{AI_ACT_CLIENT_NAME}}` | Cliente / committente a cui sono destinati i deliverable. Vuoto per i prodotti interni |
| `{{AI_ACT_SCAN_PATHS}}` | Root scansionati dall'inventario, separati da spazio. Default: la root del repository (`.`) |
| `{{AI_ACT_EXTRA_SIGNATURES}}` | Alternative `ERE` aggiuntive per librerie di IA specifiche dello stack, accodate al set di firme integrato. Vuoto va bene |
| `{{AI_ACT_OUTPUT_LANG}}` | Lingua di ogni documento generato. Default `Italiano` |
| `{{AI_ACT_LEGAL_REVIEWER}}` | Chi firma legalmente. Stampato nel blocco sign-off di ogni deliverable esterno |
| `{{CLICKUP_COMPLIANCE_DOC_ID}}` | ClickUp Doc che riceve i deliverable pubblicati (`--publish clickup`) |
| `{{INDUSTRY_SECTOR}}` | Settore del progetto — alimenta il cross-check con l'Allegato III |

Se un placeholder è ancora letterale (`{{...}}`) a run time, trattalo come **non impostato**: chiedi il valore con `AskUserQuestion` e scrivi la risposta in `00-context.md`. Non indovinarlo mai, e non inventare mai `{{AI_ACT_ORG_NAME}}` — è il singolo fatto che più cambia l'esito.

---

## REGOLE OBBLIGATORIE

### 1. La skill è l'autorità
Carica la skill **`ai-act-check`** prima di ogni classificazione, e segui le sue fasi nell'ordine (fatti → divieti → ruolo → classe di rischio → obblighi → output). Questo command aggiunge solo ciò che una skill non può fare: legge il codice, persiste i risultati e li rende per tre audience. **Ogni affermazione legale viene dalla skill e dalle sue `references/`** — mai dalla tua memoria del regolamento, e mai da una ricerca web a meno che il file `references/fonti-e-strumenti.md` della skill nomini quella fonte come ufficiale.

### 2. Nessun fatto senza provenienza
Due tipi di fatti, mai mescolati:
- **Fatti dal codice** — ogni voce dell'inventario porta `file:line`. Se non l'hai letto, non entra. Stessa regola di `docs-policy`: un'invenzione plausibile è peggio di una lacuna, perché nessuno la ri-controlla.
- **Fatti dall'umano** — ruolo, marchio, chi è esposto agli output, stato di deployment. Vivono in `00-context.md`, sono **human-owned** e non vengono mai sovrascritti né dedotti dal nome del repo.

Tutto ciò che è ignoto si scrive come `⚠️ NON VERIFICATO — <cosa manca>` più **come cambierebbe la valutazione nei due scenari** (skill, Fase 1).

### 3. Obbligo vs prudenza
Ogni azione è taggata `[OBBLIGO art. X]` o `[PRUDENZA]`. Confondere le due porta il cliente a spendere dove nulla è richiesto e costa credibilità. Le sanzioni si citano solo dove pertinenti, con il massimale corretto (skill, "Non allarmare").

### 4. Non è un parere legale
Ogni artifact e ogni deliverable esterno si chiude con il blocco sign-off (vedi *Blocco sign-off* più sotto), che nomina `{{AI_ACT_LEGAL_REVIEWER}}`. Le decisioni di perimetro e le clausole contrattuali sono validate da un legale.

### 5. I deliverable non sono intercambiabili
Il documento per `{{AI_ACT_CLIENT_NAME}}` (obblighi, istruzioni per l'uso art. 13, addendum contrattuale) e l'informativa per i **suoi end-user** (disclosure art. 50, marcatura dei contenuti generati) hanno audience diverse, contenuto diverso e basi giuridiche diverse. Non fonderli mai in un unico file.

### 6. Le regole generate per gli agenti portano la loro validità
`.claude/rules/ai-act.md` è letto alla cieca da ogni agente. Se la classificazione che c'è dietro è sbagliata, l'errore si propaga a ogni feature. Il file generato porta quindi `context_hash` + `generated_at`, e `/ai-act gate` lo marca **STALE** non appena il contesto o l'inventario cambiano.

### 7. Ownership della wiki
`docs/wiki/concepts/ai-act.md` segue `docs-policy`: `## Business (human-owned 🔒)` non viene **mai** sovrascritta; solo `## Implementazione (auto-derived 🔄)` viene rigenerata. Le divergenze vanno sotto `## Drift / Open questions`.

---

## LAYOUT DEGLI ARTIFACT

```
{{AI_ACT_DIR}}/
  00-context.md        fatti human-owned (ruolo, marchio, utenti, deployment) — chiesti una volta, riusati
  01-inventory.md      componenti IA trovati nel codice, ognuno con file:line — rigenerato a ogni scan
  02-assessment.md     divieti → ruolo → classe di rischio → obblighi con scadenze
  03-actions.md        azioni per il team dev · azioni per il cliente · clausole contrattuali
  04-client-brief.md   deliverable per {{AI_ACT_CLIENT_NAME}}  (modo docs --client)
  05-end-user-notice.md deliverable per gli end-user del cliente (modo docs --end-users)
  99-state.json        hash, date di esecuzione, tracking della staleness
```

Generati fuori dalla directory:
- `.claude/rules/ai-act.md` — vincoli che gli agenti leggono durante `/create` (modo `rules`)
- `docs/wiki/concepts/ai-act.md` — pagina wiki leggibile dagli agenti (modo `rules`)

La directory è **committata**. È proprio il punto: una seconda esecuzione diffa contro la prima, e i "punti di attenzione futuri" della skill (ciò che farebbe cambiare classe di rischio) smettono di essere un promemoria e diventano un controllo meccanico.

### Schema di `99-state.json`

```json
{
  "schema": 1,
  "last_run": { "scan": "2026-08-04", "rules": null, "docs": null, "gate": null },
  "context_hash": "<sha1 di 00-context.md>",
  "inventory_hash": "<sha1 di 01-inventory.md>",
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

## INSTRADAMENTO DEI MODI

Primo token di `$ARGUMENTS`:

| Token | Cosa fa | Richiede |
|-------|---------|----------|
| `scan` (o vuoto) | Inventaria il codice, classifica, elenca gli obblighi, scrive `01`–`03`, stampa il riepilogo | — |
| `rules` | Genera `.claude/rules/ai-act.md` + la pagina wiki dall'assessment | `02-assessment.md` |
| `docs --client` | Brief per il cliente: obblighi ripartiti per parte, istruzioni per l'uso (art. 13), addendum contrattuale | `02-assessment.md`, `03-actions.md` |
| `docs --end-users` | Informativa di trasparenza per gli end-user (art. 50): disclosure del chatbot, marcatura dei contenuti generati | `02-assessment.md` |
| `gate [<ref>]` | Ri-triage di un diff: questa modifica aggiunge un componente IA o altera la finalità prevista? Exit non-zero su un cambio di classe | `99-state.json` |
| `status` | Stampa classificazione, staleness, ignoti, scadenze entro 180 giorni. Non cambia nulla | `99-state.json` |

`--publish clickup|artifact|both` si applica solo a `docs`. `--force-context` ri-chiede il questionario di contesto anche se `00-context.md` esiste.

Se il primo token non è nessuno dei precedenti, tratta l'intero `$ARGUMENTS` come una domanda libera: carica la skill e rispondi — senza scrivere nulla.

---

## PHASE 0 — Bootstrap (ogni modo)

```bash
mkdir -p "{{AI_ACT_DIR}}"
test -f "{{AI_ACT_DIR}}/99-state.json" || printf '{"schema":1,"last_run":{},"classification":{"risk_class":"indeterminato","role":"unknown"},"unknowns":[]}\n' > "{{AI_ACT_DIR}}/99-state.json"
```

Leggi, in quest'ordine: `99-state.json`, `00-context.md` (se presente), `docs/wiki/gotchas.md` (se presente). Poi carica la skill `ai-act-check`.

---

## MODO `scan`

### SCAN-1 — Contesto (fatti human-owned)

Se `00-context.md` esiste e `--force-context` non è stato passato, **leggilo e salta a SCAN-2**. Stampa una riga: `Contesto: riuso {{AI_ACT_DIR}}/00-context.md del <data>`.

Altrimenti raccogli i fatti della Fase 1 della skill con `AskUserQuestion` — raggruppati, mai una domanda per fatto:

1. **Ruolo e marchio** — con quale nome il sistema arriva sul mercato, e chi lo mette in servizio? Opzioni costruite da `{{AI_ACT_ORG_NAME}}` / `{{AI_ACT_CLIENT_NAME}}` / *terzo fornitore di componenti* / *non lo so ancora*.
2. **Esposti agli output** — personale interno · clienti business del cliente · consumatori · pubblico generale · minori (multiSelect).
3. **Decisioni su persone fisiche** — nessuna · supporta una decisione umana · decide autonomamente; e in quale ambito (lavoro/HR, credito, assicurazioni, istruzione, salute, servizi pubblici essenziali, giustizia, migrazione, biometria, nessuna).
4. **Stato** — idea · demo su dati fittizi · sviluppo · prova in condizioni reali · produzione.

La distinzione *demo su dati fittizi* vs *prova in condizioni reali* non è cosmetica: l'art. 2 §8 copre la prima e **non** la seconda.

Scrivi `00-context.md`:

```markdown
---
type: ai-act-context
owner: human
updated: <YYYY-MM-DD>
org_name: "<{{AI_ACT_ORG_NAME}}>"
client_name: "<{{AI_ACT_CLIENT_NAME}}>"
role_declared: provider|deployer|component-supplier|unknown
market_name: "<marchio con cui il sistema arriva sul mercato>"
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

### SCAN-2 — Inventario dal codice

Scansiona `{{AI_ACT_SCAN_PATHS}}` (ripiega sulla root del repo se non impostato). Usa `Grep`/`rg`; per qualsiasi cosa ambigua, dispaccia l'agente `Explore` per tracciare come il componente è effettivamente usato — una dipendenza in `package.json` che nessuno importa non è un componente IA del sistema.

Set di firme (estendi con `{{AI_ACT_EXTRA_SIGNATURES}}`):

| Classe | Firme (case-insensitive) |
|--------|--------------------------|
| Modelli generativi / GPAI | `anthropic`, `@anthropic-ai`, `claude-`, `openai`, `gpt-4`, `gpt-5`, `mistral`, `cohere`, `gemini`, `genai`, `ollama`, `llama`, `bedrock`, `azure.*openai` |
| Orchestrazione LLM | `langchain`, `llamaindex`, `semantic-kernel`, `haystack`, `crewai`, `autogen`, `mcp` |
| Embedding / RAG | `embedding`, `pgvector`, `pinecone`, `qdrant`, `weaviate`, `chroma`, `faiss`, `vector_store` |
| ML classico / scoring | `sklearn`, `scikit`, `xgboost`, `lightgbm`, `tensorflow`, `torch`, `onnx`, `predict\(`, `\.score\(`, `risk_score`, `scoring` |
| Biometria / visione | `face`, `facial`, `fingerprint`, `iris`, `mediapipe`, `opencv`, `deepface`, `insightface`, `emotion` |
| Voce / audio | `whisper`, `speech_to_text`, `tts`, `voice_clone`, `elevenlabs` |
| Contenuti sintetici (art. 50) | `image_gen`, `stable-diffusion`, `dall-e`, `midjourney`, `deepfake`, `avatar` |
| Domini ad alto rischio (Allegato III) | `candidat`, `cv_`, `resume`, `hiring`, `recruit`, `performance_review`, `credit`, `creditworthiness`, `insurance`, `premium`, `student`, `exam`, `grading`, `triage`, `diagnos`, `welfare`, `benefit` |
| Dati art. 9 GDPR | `health`, `biometric`, `ethnic`, `religio`, `political`, `union_member`, `sexual`, `criminal` |

Per ogni hit che supera il controllo *è davvero usato*, produci una riga di inventario. Poi scrivi `01-inventory.md`:

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
- **Finalità prevista**: <a cosa serve, nel prodotto — non cosa può fare la libreria>
- **Output verso**: <chi legge l'output>
- **Revisione umana**: presente `path:line` · assente · ⚠️ NON VERIFICATO
- **Dati trattati**: <campi> — art. 9 GDPR: sì/no

## Segnali di dominio rilevati
| Segnale | Dove | Perché rileva |
|---------|------|---------------|

## Non verificato
- ⚠️ …
```

**Il campo revisione umana è la riga più preziosa del file.** Secondo la skill, un punto di fermo obbligatorio prima dell'output fa cadere obblighi (art. 50 §4), attenua la classificazione (art. 6 §3 lett. c) e riduce l'esposizione contrattuale. Cercalo nel codice — un flag di approvazione, uno `status: pending_review`, un passo di pubblicazione manuale — e registra dov'è o che manca.

### SCAN-3 — Triage

Esegui le Fasi 2 → 5 della skill su `00-context.md` + `01-inventory.md`. Nell'ordine, senza scorciatoie:

1. **Divieti (art. 5)** — incluso il nuovo meccanismo dell'art. 5 §1-bis: un componente generativo il cui esito vietato è *ragionevolmente prevedibile e riproducibile senza modifiche tecniche significative*, in assenza di misure di sicurezza ragionevoli, è colpito. Un generatore di immagini su prompt non filtrati è esattamente questo caso. Se ricorre un divieto, **fermati**: scrivi `02-assessment.md` con il divieto, salta la tabella degli obblighi e dì chiaramente che il sistema non si può realizzare in quella forma.
2. **Ruolo** — art. 3 n. 3 / n. 4, più i tre trasferimenti dell'art. 25 §1. Controlla esplicitamente la lett. c) (una modifica della finalità prevista che rende ad alto rischio un sistema che non lo era — anche per finalità generali): è quella che colpisce gli integratori.
3. **Classe di rischio** — art. 6 §1 (le due condizioni sono **cumulative**), art. 6 §2 + Allegato III, deroghe dell'art. 6 §3 con il **knock-out sulla profilazione**, art. 50, fuori perimetro + esclusioni dell'art. 2.
4. **Obblighi + scadenze** — da `references/scadenzario.md`, **mai a memoria**: il Digital Omnibus ha spostato le date. Distingui gli obblighi del fornitore da quelli del deployer. Ricorda che l'art. 4 (alfabetizzazione in materia di IA) si applica indipendentemente dalla classe di rischio dal 2 febbraio 2025.

Scrivi `02-assessment.md` (frontmatter + le sezioni 1–5 e 9–10 della Fase 6 della skill) e `03-actions.md` (sezioni 6–8):

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

La sezione **Punti di attenzione futuri** è obbligatoria e concreta: quale modifica a quale componente sposterebbe la classe. Scrivila come un elenco di condizioni che un agente può verificare, perché `/ai-act gate` le verificherà.

### SCAN-4 — Stato + riepilogo

Aggiorna `99-state.json` (hash via `shasum`, classificazione, ignoti). Poi stampa, in `{{AI_ACT_OUTPUT_LANG}}`:

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

Poi accoda una riga per ogni errore di conformità ricorrente rilevato a `docs/wiki/gotchas-inbox.jsonl` (vedi la skill `gotchas`), se quel file esiste.

---

## MODO `rules`

Richiede `02-assessment.md`. Se il suo `context_hash` non corrisponde più a `00-context.md`, rifiuta e di' all'utente di rilanciare `scan` — generare regole da un assessment stantìo è il failure mode che la regola 6 esiste per prevenire.

### RULES-1 — `.claude/rules/ai-act.md`

I `globs` sono **derivati dall'inventario**, non un `**/*` generico: l'unione delle directory che contengono i componenti in `01-inventory.md`. Le regole scoped vengono lette dove contano e ignorate dove no.

```markdown
---
globs: "<derivati da 01-inventory.md>"
---

# AI Act — vincoli operativi

> Generato da `/ai-act rules` il <data> da `{{AI_ACT_DIR}}/02-assessment.md`.
> context_hash: <…> · inventory_hash: <…>
> **Se il contesto o l'inventario cambiano queste regole sono STALE**: rilancia `/ai-act scan`.
> Classificazione corrente: <classe> · ruolo: <ruolo>.

## Vincoli non negoziabili [OBBLIGO]
- <una riga per ogni obbligo che vincola il codice, con l'articolo>

## Cosa fa cambiare classe di rischio
- <condizione> → <nuova classe> → **fermati e chiedi**, non implementare

## Da fare in ogni feature che tocca un componente IA
- <es. logging art. 12, revisione umana, disclosure art. 50 nella UI>

## Buone prassi [PRUDENZA]
- <non richiesto, consigliato>
```

La sezione **"cosa fa cambiare classe"** è quella che si ripaga: trasforma la fotografia statica dell'assessment in una condizione di stop che un agente incontra *prima* di scrivere il codice.

### RULES-2 — `docs/wiki/concepts/ai-act.md` (solo se una wiki esiste già)

**Salta interamente questo passo a meno che `docs/wiki/` esista già.** Questo plugin è standalone: un progetto che non ha mai adottato la wiki del template non deve vedersi materializzare `docs/wiki/`. Se la directory è assente, annota `wiki: assente — passo saltato` nel report RULES-3 e prosegui.

Se `docs/wiki/` esiste, segui `docs-policy`. Se la pagina esiste, **preserva `## Business (human-owned 🔒)` alla lettera** e rigenera solo `## Implementazione (auto-derived 🔄)`. Cita `code:<path>#<symbol>` dentro le sezioni, non solo nel frontmatter, e marca come `⚠️ NON VERIFICATO` tutto ciò che non è stato letto.

Poi aggiorna `docs/wiki/index.md` e accoda a `docs/wiki/log.md` come fa `/wiki`, ed esegui `docs/wiki/lint-semantic.sh` se presente.

### RULES-3 — Report
Elenca i file generati, i `globs` derivati e quanti vincoli sono stati emessi per categoria.

---

## MODO `docs`

Richiede `02-assessment.md` + `03-actions.md`. Scritto in `{{AI_ACT_OUTPUT_LANG}}`. Due deliverable distinti (regola 5).

### `--client` → `04-client-brief.md`

Per `{{AI_ACT_CLIENT_NAME}}`. Sezioni:

1. **In tre righe** — cosa hanno, quale classe, se qualcosa è urgente.
2. **Perché li riguarda** — la ripartizione dei ruoli: cosa ricade su `{{AI_ACT_ORG_NAME}}` come fornitore/supplier e cosa ricade su di loro come deployer. Di' esplicitamente **cosa non può essere assolto al loro posto** (skill, Fase 6 §7) — es. l'informazione ai lavoratori dell'art. 26 §7, l'alfabetizzazione del proprio personale ex art. 4.
3. **Obblighi** — tabella: obbligo · articolo · chi · scadenza · cosa fare concretamente. Ognuno taggato `[OBBLIGO]` / `[PRUDENZA]`.
4. **Istruzioni per l'uso (art. 13)** — solo per i sistemi ad alto rischio: finalità prevista, limiti noti, sorveglianza umana richiesta, accuratezza attesa, uso improprio prevedibile. È un **obbligo del fornitore**: se il ruolo è provider, questa sezione non è opzionale.
5. **Cosa fa cambiare le carte in tavola** — le modifiche che riclassificherebbero il sistema.
6. **Clausole contrattuali** — da `references/clausole-contrattuali.md`; se il ruolo è *component supplier* verso un sistema ospite ad alto rischio, l'accordo scritto dell'art. 25 §4 è elencato per primo.
7. **Aree adiacenti** — GDPR, Statuto dei lavoratori, Codice del consumo, MDR dove intersecano. Spesso il rischio concreto vive qui.
8. **Blocco sign-off.**

### `--end-users` → `05-end-user-notice.md`

Per le persone esposte agli output — linguaggio semplice, nessun numero d'articolo nel corpo (vanno in nota), pronto per essere incollato in un sito, un'app o un allegato ai T&C. Includi **solo ciò che l'art. 50 effettivamente richiede** per i componenti presenti nell'inventario:

- interazione diretta con un sistema di IA → disclosure alla prima interazione, salvo che sia ovvia per una persona ragionevolmente informata;
- audio/immagine/video/testo sintetici → marcatura leggibile dalla macchina del contenuto generato;
- deepfake → dichiarato come generato artificialmente, con l'eccezione editoriale dell'art. 50 §4 dove un umano detiene la responsabilità editoriale;
- riconoscimento delle emozioni / categorizzazione biometrica → informazione alla persona esposta.

Se nessuna si applica, dillo in una riga e **non** fabbricare un'informativa: una disclosure non necessaria abitua gli utenti a ignorare quelle necessarie.

### Pubblicazione

- `--publish clickup` → `mcp__clickup__clickup_create_document` / `clickup_create_document_page` sotto `{{CLICKUP_COMPLIANCE_DOC_ID}}`, una pagina per deliverable. Registra il Doc ID in `99-state.json`.
- `--publish artifact` → una pagina HTML tramite il tool `Artifact`, per il deliverable che il cliente legge davvero. **Chiedi prima di pubblicare** (una URL di artifact è condivisibile), non impersonare mai il branding del cliente, e mantieni il blocco sign-off visibile sulla pagina.
- `--publish both` → entrambi, con la stessa conferma.
- Nessun flag → solo file.

### Blocco sign-off (obbligatorio, ogni deliverable esterno)

```markdown
---
**Nota** — Documento tecnico di supporto, non parere legale. Le decisioni di perimetro,
la classificazione e le clausole contrattuali vanno validate da {{AI_ACT_LEGAL_REVIEWER}}.
Basato sul Reg. (UE) 2024/1689 come modificato dal Reg. (UE) 2026/1744.
Valutazione al <data>, su un sistema nello stato: <lifecycle>. Elementi non verificati: <N>.
```

---

## MODO `gate`

Il ponte verso la pipeline di sviluppo. Gira su un diff — `git diff <ref>...HEAD --name-only` con `<ref>` che defaulta al merge base con il branch main.

1. Carica `99-state.json`. Nessuno scan precedente → stampa `AI-ACT: no baseline` ed exit 0 (non bloccare mai un progetto che non ha mai eseguito il triage).
2. Riesegui il set di firme di SCAN-2 **solo sui file modificati**.
3. Verdetti:

| Condizione | Verdetto |
|------------|----------|
| Nessuna firma IA nel diff | `PASS` |
| Firma IA in file già in `01-inventory.md`, finalità invariata | `PASS` (annotalo) |
| Nuovo componente IA non nell'inventario | `STALE` — esegui `/ai-act scan` |
| Il diff corrisponde a una condizione dei *Punti di attenzione futuri* | `RECLASSIFY` — fermati, decisione umana richiesta |
| Una firma colpisce una pratica vietata (art. 5) | `BLOCK` — mai automatico, escala all'utente |
| `context_hash` ≠ hash di `00-context.md` | `STALE` |

4. Stampa il verdetto, l'evidenza `file:line` e il comando successivo esatto. `RECLASSIFY` e `BLOCK` escono con exit non-zero.

**Questo gate non tocca `hooks/pipeline-validate.sh`.** È invocato esplicitamente — da `/create` quando la descrizione della task menziona un componente IA, o manualmente prima di una PR. Cablarlo nell'hook è una decisione separata, presa una volta che la classificazione è stabile.

---

## MODO `status`

Legge `99-state.json` e gli artifact, non scrive nulla:

```
Classe: <…>   Ruolo: <…>   Ultimo scan: <data>
Regole agenti: aggiornate | STALE (context_hash difforme) | mai generate
Componenti IA: N          Elementi non verificati: M
Scadenze nei prossimi 180 giorni:
  <data> — <obbligo> (art. X) — <chi>
Deliverable: 04-client-brief.md <data> · 05-end-user-notice.md <mai>
```

---

## FAILURE MODE DA EVITARE

- **Classificare una tecnologia invece di un sistema.** "Usiamo un LLM" non è una classificazione. Lo stesso modello è fuori perimetro in un assistente documentale e ad alto rischio in uno screening di CV. Classifica sempre *un componente con una finalità prevista*, presa da `00-context.md`.
- **Dedurre il ruolo da chi scrive il codice.** Viene da chi ha il nome sul mercato. Se `00-context.md` dice `unknown`, l'assessment dice `indeterminato` e mostra entrambi i rami — non sceglie quello comodo.
- **Rivendicare gratis una deroga dell'art. 6 §3.** Va documentata prima dell'immissione sul mercato e richiede comunque la registrazione nella banca dati UE (art. 6 §4, art. 49 §2), ed è del tutto indisponibile se il sistema profila persone fisiche.
- **Citare il calendario del 2024.** Il Digital Omnibus ha spostato le date. Leggi sempre `references/scadenzario.md`.
- **Produrre un'informativa che non serve a nessuno.** Vedi `docs --end-users`.
- **Lasciare che `rules` sopravviva al suo assessment.** È a questo che serve `context_hash`.

---

## CHECKLIST

- [ ] skill `ai-act-check` caricata prima di ogni classificazione
- [ ] `00-context.md` presente e confermato dall'umano (non dedotto)
- [ ] Righe dell'inventario tutte con `file:line`; dipendenze inutilizzate escluse
- [ ] Presenza della revisione umana registrata per ogni componente
- [ ] Divieti (art. 5) controllati **per primi**, art. 5 §1-bis incluso
- [ ] Ruolo determinato con i trasferimenti dell'art. 25 controllati, lett. c) esplicitamente
- [ ] Classe di rischio derivata nell'ordine della skill; knock-out sulla profilazione applicato
- [ ] Scadenze prese da `references/scadenzario.md`, non a memoria
- [ ] Ogni azione taggata `[OBBLIGO art. X]` o `[PRUDENZA]`
- [ ] Ignoti elencati con impatto nei due scenari
- [ ] `99-state.json` aggiornato con hash freschi
- [ ] Regole generate con `context_hash` e l'avviso di staleness
- [ ] Wiki `## Business (human-owned 🔒)` intatta
- [ ] Blocco sign-off su ogni deliverable esterno
- [ ] Pubblicazione su ClickUp/Artifact confermata dall'utente prima che avvenga

---

## AVVIO ESECUZIONE

Fai il parse del modo da `$ARGUMENTS`, esegui PHASE 0, carica la skill `ai-act-check`, poi esegui il modo.
