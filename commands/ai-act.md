---
allowed-tools: Read, Write, Edit, Glob, Grep, Bash(mkdir:*), Bash(test:*), Bash(ls:*), Bash(git:*), Bash(grep:*), Bash(rg:*), Bash(jq:*), Bash(date:*), Bash(shasum:*), Bash(wc:*), Bash(sed:*), Agent, AskUserQuestion, WebSearch, WebFetch, Artifact, TodoWrite
argument-hint: <scan|check <norma>|rules|docs|report|gate|status> [--client | --end-users] [--publish clickup|artifact|both] [--force-context]
description: Conformità all'AI Act per questo progetto (Reg. UE 2024/1689 come modificato dal Reg. UE 2026/1744). Scansiona il codice e la documentazione, interroga chi conosce il progetto, classifica rischio e ruolo, verifica se il sistema è a norma (non solo lo scan), risponde a domande su singole norme, genera le regole per gli agenti, i documenti per il cliente e un report HTML di conformità. Carica sempre la skill ai-act-check.
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
| `{{AI_ACT_SCAN_PATHS}}` | Root del **codice** scansionati dall'inventario, separati da spazio. Default: la root del repository (`.`) |
| `{{AI_ACT_DOC_PATHS}}` | Percorsi della **documentazione di progetto** scansionati da SCAN-2b, separati da spazio. Default: `README* docs/ doc/ specs/ *.md` |
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
  06-report.html       report HTML di conformità: problemi · non-problemi · correzioni (modo report)
  99-state.json        hash, date di esecuzione, conformità, tracking della staleness
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
  "compliance": "conforme|non-conforme|incerto|non-applicabile",
  "open_problems": 0,
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
| `scan` (o vuoto) | Inventaria il codice **e la documentazione di progetto**, interroga l'utente, classifica, verifica la conformità, scrive `01`–`03`, stampa il riepilogo | — |
| `check <norma>` | Domanda mirata su una singola norma (es. `check art.50`, `check allegato-iii`): chiede solo i fatti da cui quella norma dipende e risponde **se sei a norma o cosa manca**. Non rifà l'intero triage, non scrive file | — |
| `rules` | Genera `.claude/rules/ai-act.md` + la pagina wiki dall'assessment | `02-assessment.md` |
| `docs --client` | Brief per il cliente: obblighi ripartiti per parte, istruzioni per l'uso (art. 13), addendum contrattuale | `02-assessment.md`, `03-actions.md` |
| `docs --end-users` | Informativa di trasparenza per gli end-user (art. 50): disclosure del chatbot, marcatura dei contenuti generati | `02-assessment.md` |
| `report` | Genera un **report HTML** di conformità (problemi · non-problemi · correzioni) da `02-assessment.md`. `--publish artifact` per pubblicarlo | `02-assessment.md` |
| `gate [<ref>]` | Ri-triage di un diff (codice **e** doc modificati): aggiunge un componente IA o altera la finalità prevista? Exit non-zero su un cambio di classe | `99-state.json` |
| `status` | Stampa classificazione, conformità, staleness (norme e assessment), ignoti, scadenze entro 180 giorni. Non cambia nulla | `99-state.json` |

`--publish clickup|artifact|both` si applica a `docs` e `report`. `--force-context` ri-chiede il questionario di contesto anche se `00-context.md` esiste.

Se il primo token non è nessuno dei precedenti, tratta l'intero `$ARGUMENTS` come una domanda libera: carica la skill e rispondi — senza scrivere nulla.

---

## PHASE 0 — Bootstrap (ogni modo)

```bash
mkdir -p "{{AI_ACT_DIR}}"
test -f "{{AI_ACT_DIR}}/99-state.json" || printf '{"schema":1,"last_run":{},"classification":{"risk_class":"indeterminato","role":"unknown"},"compliance":"incerto","open_problems":0,"unknowns":[]}\n' > "{{AI_ACT_DIR}}/99-state.json"
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

Le firme hanno **due livelli di confidenza** e non pesano uguale: un import di libreria IA è una prova, una parola di dominio nella prosa è solo un indizio. Estendi con `{{AI_ACT_EXTRA_SIGNATURES}}` (entra in `weak` salvo tu indichi il livello).

**Livello `strong` — import/uso di tecnologia IA. Un hit qui è candidato-componente diretto** (resta il check *è davvero usato*).

| Classe | Firme (case-insensitive) |
|--------|--------------------------|
| Modelli generativi / GPAI | `anthropic`, `@anthropic-ai`, `claude-`, `openai`, `gpt-4`, `gpt-5`, `mistral`, `cohere`, `gemini`, `genai`, `ollama`, `bedrock`, `azure.*openai` |
| Orchestrazione LLM | `langchain`, `llama[-_]?index`, `semantic-kernel`, `haystack`, `crewai`, `autogen` |
| Embedding / RAG | `pgvector`, `pinecone`, `qdrant`, `weaviate`, `chroma`, `faiss`, `fastembed`, `vector_store`, `VectorStoreIndex` |
| ML classico / scoring | `sklearn`, `scikit`, `xgboost`, `lightgbm`, `tensorflow`, `\btorch\b`, `onnx` |
| Biometria / visione | `mediapipe`, `opencv`, `deepface`, `insightface` |
| Voce / audio | `whisper`, `elevenlabs`, `voice_clone` |
| Contenuti sintetici (art. 50) | `stable-diffusion`, `dall-e`, `midjourney`, `deepfake` |

**Livello `weak` — parole di dominio o termini generici. Un hit qui NON è mai da solo un componente**: segnala un *contesto* da confermare con codice `strong` vicino o con l'umano. Senza alcun `strong` nel modulo, un `weak` va in "Segnali di dominio" e "Non verificato", **non** in "Componenti".

| Classe | Firme (case-insensitive) | Perché è debole |
|--------|--------------------------|-----------------|
| Termini ambigui | `llama`, `\bmcp\b`, `embedding`, `predict\(`, `\.score\(`, `risk_score`, `scoring`, `avatar`, `image_gen`, `\btts\b`, `speech_to_text`, `face`, `facial`, `fingerprint`, `iris`, `emotion` | `llama` colpisce `llama-index` (orchestrazione, non il modello); `score`/`predict`/`face`/`emotion` ricorrono in codice non-IA |
| Domini ad alto rischio (Allegato III) | `candidat`, `cv_`, `resume`, `hiring`, `recruit`, `performance_review`, `credit`, `creditworthiness`, `insurance`, `premium`, `student`, `exam`, `grading`, `triage`, `diagnos`, `welfare`, `benefit` | indicano *dominio*, non *tecnologia*: contano per la classe **solo se** c'è un componente `strong` che opera su quel dominio |
| Dati art. 9 GDPR | `health`, `biometric`, `ethnic`, `religio`, `political`, `union_member`, `sexual`, `criminal` | idem: contano se un componente `strong` tratta quei dati |

**Regola di promozione:** un componente d'inventario nasce da almeno un hit `strong` che supera il check *è davvero usato*. Gli hit `weak` qualificano quel componente (dominio, dati, finalità), non lo creano. Un repo pieno di `weak` senza nessun `strong` **non ha componenti IA** — dillo, non inventarli.

**Robustezza del parsing.** I manifest di dipendenze (`requirements*.txt`, `package.json`, `pyproject.toml`, `go.mod`, `Gemfile`) vanno letti anche se rinominati o con refusi (es. `requiremts.txt`): cerca per contenuto, non solo per nome file. Una dipendenza dichiarata ma mai importata resta fuori dall'inventario (check *è davvero usato*).

Per ogni componente promosso, produci una riga di inventario. Poi scrivi `01-inventory.md`:

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

### SCAN-2b — Rilievo dalla documentazione di progetto

Il codice dice cosa il sistema **fa oggi**; la documentazione dice cosa il sistema **dichiara di fare** — e le due cose divergono. Un componente IA descritto in una spec ma non ancora scritto, una finalità d'uso che il codice non tradisce, una promessa commerciale ("scoring dei candidati", "diagnosi assistita") che cambierebbe la classe: sono segnali che lo scan del solo codice perde. Questo passo li recupera, **senza mai promuoverli a fatti**.

Scansiona i documenti di progetto in `{{AI_ACT_DOC_PATHS}}` (default: `README*`, `docs/`, `doc/`, `specs/`, `*.md` nella root — ripiega su `README*` + `*.md` root se non impostato). **Escludi** gli artifact prodotti da questo command (`{{AI_ACT_DIR}}/`, `.claude/rules/ai-act.md`, `docs/wiki/concepts/ai-act.md`): non rileggere ciò che hai scritto tu.

Cerca in linguaggio naturale — non firme di codice: menzioni di IA/ML, finalità dichiarate ("il sistema serve a…", "usato per…"), i termini di dominio ad alto rischio dell'Allegato III (assunzioni, credito, assicurazioni, istruzione, salute, biometria, giustizia, migrazione), e le funzionalità **pianificate ma non ancora implementate** ("in roadmap", "TODO", "fase 2", "prossima release").

**Regole ferree per questo passo — la documentazione è prosa, non prova:**
- Ogni rilievo da documentazione è marcato `⚠️ NON VERIFICATO — da documentazione: <path:line>`. Non ottiene mai un'evidenza `file:line` di codice, perché non ne ha una.
- Un rilievo da documentazione **non diventa mai** un componente classificato con obblighi propri. Alimenta i *punti di attenzione* e gli *ignoti*, non la tabella degli obblighi.
- La documentazione **non sovrascrive** `00-context.md` (human-owned) né lo deduce. Se un documento afferma una finalità o un ruolo che il questionario non conferma, è una **divergenza da segnalare**, non una correzione da applicare.
- Se un documento descrive una pratica potenzialmente **vietata** (art. 5) o un uso **ad alto rischio** che il codice non mostra, è il segnale più prezioso del passo: portalo in cima ai *Punti di attenzione futuri* e proponi all'umano di confermarlo o smentirlo.

Aggiungi a `01-inventory.md` due sezioni (vuote se non emerge nulla — non fabbricare rilievi):

```markdown
## Dichiarato nella documentazione (⚠️ non riscontrato nel codice)
| Cosa | Dove (doc) | Riscontro nel codice | Impatto potenziale sulla classe |
|------|-----------|----------------------|---------------------------------|
| <componente/finalità descritta> | `README.md:12` | assente · parziale `path:line` | <es. alto rischio se implementato: Allegato III §4 lavoro> |

## Divergenze codice ↔ documentazione ↔ contesto
| Affermazione | Fonte | In conflitto con | Da chiarire con l'umano |
|--------------|-------|------------------|--------------------------|
| <es. "decide l'assunzione"> | `spec.md:8` | `00-context.md` (dice: supporta) · codice (nessuna decisione autonoma) | sì |
```

### SCAN-3 — Triage

Esegui le Fasi 2 → 5 della skill su `00-context.md` + `01-inventory.md`. **La classificazione e gli obblighi si fondano solo sul codice (`## Componenti`) e sul contesto umano** — mai su un rilievo da documentazione. I rilievi delle sezioni SCAN-2b confluiscono invece negli *ignoti* del frontmatter e, se toccano un divieto o un uso ad alto rischio, in cima ai *Punti di attenzione futuri*: sono ipotesi da confermare con l'umano, non fatti su cui classificare. Nell'ordine, senza scorciatoie:

1. **Divieti (art. 5)** — incluso il nuovo meccanismo dell'art. 5 §1-bis: un componente generativo il cui esito vietato è *ragionevolmente prevedibile e riproducibile senza modifiche tecniche significative*, in assenza di misure di sicurezza ragionevoli, è colpito. Un generatore di immagini su prompt non filtrati è esattamente questo caso. Se ricorre un divieto, **fermati**: scrivi `02-assessment.md` con il divieto, salta la tabella degli obblighi e dì chiaramente che il sistema non si può realizzare in quella forma.
2. **Ruolo** — art. 3 n. 3 / n. 4, più i tre trasferimenti dell'art. 25 §1. Controlla esplicitamente la lett. c) (una modifica della finalità prevista che rende ad alto rischio un sistema che non lo era — anche per finalità generali): è quella che colpisce gli integratori.
3. **Classe di rischio** — art. 6 §1 (le due condizioni sono **cumulative**), art. 6 §2 + Allegato III, deroghe dell'art. 6 §3 con il **knock-out sulla profilazione**, art. 50, fuori perimetro + esclusioni dell'art. 2. **Se il sistema ha più componenti con finalità diverse, classifica ciascuno per sé** (skill, Fase 1): la classe complessiva del progetto è la più alta fra i suoi componenti, ma la tabella li tiene distinti.
4. **Obblighi + scadenze** — da `references/scadenzario.md`, **mai a memoria**: il Digital Omnibus ha spostato le date. Distingui gli obblighi del fornitore da quelli del deployer. Ricorda che l'art. 4 (alfabetizzazione in materia di IA) si applica indipendentemente dalla classe di rischio dal 2 febbraio 2025. Per ogni riga cita l'ancora EUR-Lex (`art. X §Y`) così che il legale possa fare lo spot-check.
5. **Verdetto di conformità** (skill, Fase 5-bis) — per ogni obbligo applicabile stabilisci ✅ soddisfatto / ❌ non soddisfatto / ⚠️ incerto, **con l'evidenza** (`file:line` dal codice o fatto confermato in `00-context.md`). Nessuna evidenza ⇒ non è "soddisfatto", è "incerto". Da qui derivano i tre elenchi — **Problemi** (obblighi ❌), **Non è un problema** (timori che non si applicano o già ✅), **Correzioni** (l'azione che chiude ogni ❌).

Scrivi `02-assessment.md` (frontmatter + le sezioni 1–6 e 10–11 della Fase 6 della skill, inclusa la **Conformità**) e `03-actions.md` (sezioni 7–9):

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
compliance: conforme|non-conforme|incerto|non-applicabile
open_problems: <N>
unknowns: <N>
---
```

La sezione **Conformità** di `02-assessment.md` ha forma fissa:

```markdown
## Conformità

| Obbligo | Art. | Verdetto | Evidenza | Correzione (se ❌) |
|---------|------|----------|----------|--------------------|
| Disclosure interazione IA | art. 50 §1 | ❌ non soddisfatto | `src/agent.py:93` si presenta come persona | aggiungere disclosure IA alla prima interazione |

### Problemi (obblighi non soddisfatti)
- ❌ <obbligo> — <cosa manca> — art. X

### Non è un problema
- ✅/➖ <timore comune> — perché non si applica o è già soddisfatto (es. fuori Allegato III; esclusione art. 2 §8; art. 50 §2 non pertinente)

### Correzioni da effettuare
1. <azione concreta> — art. X — <punto nel codice se pertinente>
```

La sezione **Punti di attenzione futuri** è obbligatoria e concreta: quale modifica a quale componente sposterebbe la classe. Scrivila come un elenco di condizioni che un agente può verificare, perché `/ai-act gate` le verificherà.

### SCAN-4 — Stato + riepilogo

Aggiorna `99-state.json` (hash via `shasum`, classificazione, `compliance`, `open_problems`, ignoti). Poi stampa, in `{{AI_ACT_OUTPUT_LANG}}`:

```
## Esito
<classe> · <ruolo> · conformità: <conforme|non-conforme|incerto|n/a> · <azione urgente: sì|no>

## Componenti IA: N   Problemi aperti: P   Ignoti: M

## Problemi (obblighi non soddisfatti) — ordinati per scadenza
| # | problema | art. | scadenza | correzione |

## Obblighi con scadenza entro 180 giorni
| obbligo | art. | chi | scadenza | azione |

## Prossimi passi
/ai-act report  → report HTML (problemi · non-problemi · correzioni)
/ai-act rules   → vincoli per gli agenti
/ai-act docs --client / --end-users
```

Ordina i problemi per scadenza crescente, poi per gravità (divieto > alto rischio > trasparenza). Se `compliance` è `conforme` o `non-applicabile`, stampa una riga esplicita "Nessun problema aperto" invece della tabella vuota. **Confine noto, da dire una volta nel riepilogo:** lo scan vede solo il repository — documentazione esterna (Notion, Confluence, ticket) e fatti non messi in `00-context.md` restano fuori.

Poi accoda una riga per ogni errore di conformità ricorrente rilevato a `docs/wiki/gotchas-inbox.jsonl` (vedi la skill `gotchas`), se quel file esiste.

---

## MODO `check` — domanda mirata su una norma

Per rispondere a una singola norma senza rifare l'intero triage. Il secondo token è il riferimento: `check art.50`, `check art.5`, `check allegato-iii`, `check marcatura-ce`, `check art.6`, `check deroga`, oppure una domanda libera che nomina una norma (`check "mi serve il watermark?"`).

1. Carica la skill `ai-act-check` e apri il file `references/` pertinente alla norma.
2. Riusa `00-context.md` e `01-inventory.md` se esistono. **Non basta:** ogni norma dipende da pochi fatti (vedi *Domande mirate su una singola norma* nella skill). Se quei fatti non ci sono, **chiedili con `AskUserQuestion`** — solo l'utente li conosce — ma limitati a quelli che servono per quella norma, non all'intero questionario.
3. Rispondi con: la regola dalla `references/` (con `art. X §Y`), la sua applicazione al sistema sui fatti raccolti, e il **verdetto**: ✅ a norma / ❌ manca <cosa> / ⚠️ incerto, verifica <cosa>. Se ❌, indica la correzione concreta.
4. **Non scrive file** e non tocca `99-state.json`. È una consultazione. Se l'utente vuole persistere l'esito, indirizzalo a `scan`.

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

## MODO `report`

Richiede `02-assessment.md`. Genera un **report HTML di conformità** in `{{AI_ACT_DIR}}/06-report.html`, pensato per essere aperto in un browser e mostrato al cliente o al legale. Tre sezioni, nell'ordine, perché servono a decisioni diverse:

1. **Problemi** — gli obblighi ❌ non soddisfatti (dalla sezione *Conformità* dell'assessment), ordinati per scadenza crescente e gravità. Ogni card: obbligo, articolo, cosa manca, evidenza `file:line`, scadenza.
2. **Non è un problema** — ciò che è ✅ soddisfatto o ➖ non applicabile, con il perché. Serve a rassicurare e a evitare spese inutili: dire "questo NON ti riguarda" ha lo stesso valore di dire cosa correggere.
3. **Correzioni da effettuare** — elenco numerato e azionabile, una riga per problema, con l'articolo e il punto nel codice.

In testa: esito (classe · ruolo · conformità), data, stato del ciclo di vita, numero di problemi aperti e di ignoti. In coda: il **blocco sign-off** (obbligatorio, come i deliverable esterni), che nomina `{{AI_ACT_LEGAL_REVIEWER}}`.

**Requisiti dell'HTML** (il file deve funzionare da solo, offline):
- Un solo file, **CSS inline**, nessuna risorsa esterna, nessuno script necessario.
- Codifica dei verdetti a colore **e** a simbolo (❌ / ✅ / ⚠️ / ➖) — mai colore soltanto (accessibilità).
- Leggibile in stampa (il legale lo stamperà): niente sfondi scuri pieni, contrasto adeguato.
- Provenienza visibile: ogni problema mostra la sua evidenza `file:line`; ogni affermazione legale il suo articolo.
- In testa un avviso `⚠️ NON VERIFICATO` che elenca gli ignoti, così il lettore sa cosa non è stato confermato.

Il template di riferimento è in `assets/report-template.html`: leggilo e riempilo con i dati dell'assessment, non reinventare la struttura.

### Pubblicazione del report
- Nessun flag → scrive solo `{{AI_ACT_DIR}}/06-report.html` e ne stampa il percorso.
- `--publish artifact` → pubblica la stessa pagina col tool `Artifact`. **Chiedi prima** (la URL è condivisibile), non impersonare il branding del cliente, tieni visibili sign-off e avviso ignoti.
- Registra l'eventuale URL in `99-state.json` (`published.artifact_url`).

---

## MODO `gate`

Il ponte verso la pipeline di sviluppo. Gira su un diff — `git diff <ref>...HEAD --name-only` con `<ref>` che defaulta al merge base con il branch main.

1. Carica `99-state.json`. Nessuno scan precedente → stampa `AI-ACT: no baseline` ed exit 0 (non bloccare mai un progetto che non ha mai eseguito il triage).
2. Sui **file modificati**: riesegui le firme `strong`/`weak` di SCAN-2 sui file di codice, **e** il rilievo di SCAN-2b sui file di documentazione modificati (`.md`, spec). Una nuova finalità ad alto rischio può entrare da una spec prima che dal codice.
3. Verdetti:

| Condizione | Verdetto |
|------------|----------|
| Nessuna firma IA nel diff | `PASS` |
| Firma IA in file già in `01-inventory.md`, finalità invariata | `PASS` (annotalo) |
| Nuovo componente IA `strong` non nell'inventario | `STALE` — esegui `/ai-act scan` |
| Un doc modificato descrive un nuovo componente/finalità ad alto rischio | `RECLASSIFY` — verifica con l'umano (rilievo da doc, `⚠️ NON VERIFICATO`) |
| Il diff corrisponde a una condizione dei *Punti di attenzione futuri* | `RECLASSIFY` — fermati, decisione umana richiesta |
| Una firma colpisce una pratica vietata (art. 5) | `BLOCK` — mai automatico, escala all'utente |
| `context_hash` ≠ hash di `00-context.md` | `STALE` |

4. Stampa il verdetto, l'evidenza `file:line` e il comando successivo esatto. `RECLASSIFY` e `BLOCK` escono con exit non-zero.

**Questo gate non tocca `hooks/pipeline-validate.sh`.** È invocato esplicitamente — da `/create` quando la descrizione della task menziona un componente IA, o manualmente prima di una PR. Cablarlo nell'hook è una decisione separata, presa una volta che la classificazione è stabile.

---

## MODO `status`

Legge `99-state.json` e gli artifact, non scrive nulla. Legge anche la data "Ultima revisione normativa" da `references/fonti-e-strumenti.md` per l'avviso di staleness legale:

```
Classe: <…>   Ruolo: <…>   Conformità: <conforme|non-conforme|incerto|n/a>   Ultimo scan: <data>
Problemi aperti: P        Elementi non verificati: M        Componenti IA: N
Regole agenti: aggiornate | STALE (context_hash difforme) | mai generate
Corpo normativo: revisionato al <data di fonti-e-strumenti.md>  [⚠️ STALE se > 6 mesi fa → aggiorna il plugin: /plugin marketplace update ai-act]
Scadenze nei prossimi 180 giorni:
  <data> — <obbligo> (art. X §Y) — <chi>
Deliverable: 04-client-brief.md <data> · 05-end-user-notice.md <mai> · 06-report.html <mai>
```

Se i problemi aperti sono > 0, elencali sotto, ordinati per scadenza. La soglia di staleness normativa è **6 mesi** dalla data di revisione: oltre, l'affidabilità delle date non è garantita e va aggiornato il plugin.

---

## FAILURE MODE DA EVITARE

- **Classificare una tecnologia invece di un sistema.** "Usiamo un LLM" non è una classificazione. Lo stesso modello è fuori perimetro in un assistente documentale e ad alto rischio in uno screening di CV. Classifica sempre *un componente con una finalità prevista*, presa da `00-context.md`.
- **Dedurre il ruolo da chi scrive il codice.** Viene da chi ha il nome sul mercato. Se `00-context.md` dice `unknown`, l'assessment dice `indeterminato` e mostra entrambi i rami — non sceglie quello comodo.
- **Rivendicare gratis una deroga dell'art. 6 §3.** Va documentata prima dell'immissione sul mercato e richiede comunque la registrazione nella banca dati UE (art. 6 §4, art. 49 §2), ed è del tutto indisponibile se il sistema profila persone fisiche.
- **Citare il calendario del 2024.** Il Digital Omnibus ha spostato le date. Leggi sempre `references/scadenzario.md`.
- **Produrre un'informativa che non serve a nessuno.** Vedi `docs --end-users`.
- **Classificare su un'affermazione della documentazione.** Un README che promette "scoring dei candidati" non è un componente ad alto rischio finché il codice non lo realizza. Il rilievo da doc è un *punto di attenzione* da confermare con l'umano, mai la base di un obbligo. Vedi SCAN-2b.
- **Spacciare un incerto per "conforme".** Un obbligo senza evidenza è ⚠️ incerto, non ✅ soddisfatto. Un falso positivo di conformità espone il cliente più di un problema segnalato. Vedi Fase 5-bis.
- **Creare un componente da un hit `weak`.** Una parola di dominio (`credit`, `face`, `llama`) senza un hit `strong` vicino non è un componente IA. Vedi la regola di promozione in SCAN-2.
- **Non chiedere ciò che solo l'umano sa.** Finalità, ruolo, esposizione, ciclo di vita non si deducono dal codice. Se non sono in `00-context.md`, si chiedono — non si assumono. Vedi Fase 1.
- **Lasciare che `rules` sopravviva al suo assessment.** È a questo che serve `context_hash`.

---

## CHECKLIST

- [ ] skill `ai-act-check` caricata prima di ogni classificazione
- [ ] `00-context.md` presente e confermato dall'umano tramite interrogazione (Fase 1), non dedotto
- [ ] Componenti nati solo da hit `strong`; hit `weak` usati per qualificare, mai per creare
- [ ] Righe dell'inventario tutte con `file:line`; dipendenze inutilizzate escluse
- [ ] Componenti a finalità diverse classificati ciascuno per sé
- [ ] Documentazione di progetto scansionata (SCAN-2b); rilievi da doc marcati `⚠️ NON VERIFICATO — da documentazione` e mai promossi a componenti classificati
- [ ] Divergenze codice ↔ documentazione ↔ contesto segnalate, non risolte in silenzio
- [ ] Presenza della revisione umana registrata per ogni componente
- [ ] Divieti (art. 5) controllati **per primi**, art. 5 §1-bis incluso
- [ ] Ruolo determinato con i trasferimenti dell'art. 25 controllati, lett. c) esplicitamente
- [ ] Classe di rischio derivata nell'ordine della skill; knock-out sulla profilazione applicato
- [ ] Scadenze prese da `references/scadenzario.md`, non a memoria, con ancora `art. X §Y`
- [ ] Verdetto di conformità per ogni obbligo (✅/❌/⚠️) con evidenza; incerti non spacciati per soddisfatti
- [ ] Tre elenchi prodotti: Problemi · Non è un problema · Correzioni
- [ ] Ogni azione taggata `[OBBLIGO art. X]` o `[PRUDENZA]`
- [ ] Ignoti elencati con impatto nei due scenari
- [ ] `99-state.json` aggiornato con hash freschi, `compliance` e `open_problems`
- [ ] Regole generate con `context_hash` e l'avviso di staleness
- [ ] Wiki `## Business (human-owned 🔒)` intatta
- [ ] Blocco sign-off su ogni deliverable esterno
- [ ] Pubblicazione su ClickUp/Artifact confermata dall'utente prima che avvenga

---

## AVVIO ESECUZIONE

Fai il parse del modo da `$ARGUMENTS`, esegui PHASE 0, carica la skill `ai-act-check`, poi esegui il modo.
