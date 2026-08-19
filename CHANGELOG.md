# Changelog

Tutte le modifiche rilevanti a `ai-act-plugin` sono annotate qui.

Formato ispirato a [Keep a Changelog](https://keepachangelog.com/it/1.1.0/);
il versionamento segue [SemVer](https://semver.org/lang/it/).

> **Regola specifica del plugin — le `references/` sono legge.**
> Ogni modifica al corpo normativo in `skills/ai-act-check/references/` (una data, una soglia,
> una sanzione, un obbligo, una nuova voce d'Allegato) è un cambiamento **sostanziale** e richiede:
> 1. bump di `version` in `.claude-plugin/plugin.json`,
> 2. aggiornamento della data "Ultima revisione normativa" in `references/fonti-e-strumenti.md`,
> 3. una voce qui sotto che cita l'atto UE/nazionale che ha motivato la modifica.
>
> I clienti applicano l'aggiornamento con `/plugin marketplace update ai-act`.
>
> **Convenzione di versione:**
> - **MAJOR** — cambia il comportamento del command o la struttura degli artifact (rottura per chi già usa il plugin).
> - **MINOR** — nuovo modo, nuova capacità, o **aggiornamento normativo sostanziale** delle `references/`.
> - **PATCH** — correzioni di refusi, coerenza, glifi, documentazione; nessun cambio di significato legale.

## [1.2.0] — 2026-08-19

Da valutazione a verifica: il plugin ora non solo classifica, dice **se il sistema è a norma**, interroga a fondo chi conosce il progetto, risponde su singole norme e produce un report HTML.

### Aggiunto
- **Interrogazione forte dell'utente (skill, Fase 1).** La raccolta fatti diventa un vero interrogatorio: finalità reale, nome/mercato, esposti, decisioni su persone, revisione umana, dati, ciclo di vita, contesto contrattuale, modifiche previste. Solo l'umano conosce il progetto: questi fatti si chiedono, non si deducono. Componenti a finalità diverse classificati ciascuno per sé.
- **Domande mirate su singole norme** — nuovo modo `check <norma>` (es. `/ai-act check art.50`): chiede solo i fatti da cui quella norma dipende e risponde se sei a norma o cosa manca, senza rifare il triage. Nella skill: sezione "Domande mirate".
- **Verdetto di conformità (skill, Fase 5-bis)** — per ogni obbligo: ✅ soddisfatto / ❌ non soddisfatto / ⚠️ incerto, con evidenza. Tre elenchi: Problemi, Non è un problema, Correzioni. `02-assessment.md` ha una sezione `Conformità`; `99-state.json` porta `compliance` e `open_problems`.
- **Report HTML** — nuovo modo `report`: genera `06-report.html` (problemi · non-problemi · correzioni), self-contained, stampabile, verdetti a simbolo+colore, con avviso ignoti e sign-off. Template in `assets/report-template.html`. `--publish artifact` per pubblicarlo.
- **Test di regressione** — `tests/` con fixture (CV screener alto rischio, chatbot art. 50, API senza IA) + `run-signatures.sh` (grep POSIX, no `rg`): verifica che le firme `strong` rilevino i file attesi e che una fixture con sole parole `weak` non produca componenti.

### Modificato
- **Firme a due livelli (SCAN-2).** `strong` = import/uso di tecnologia IA (candidato-componente diretto); `weak` = parole di dominio/termini ambigui (qualificano, non creano). Regola di promozione: un componente nasce solo da un hit `strong`. Risolve il falso positivo `llama`→`llama-index` e il rumore delle keyword di dominio su codice non-IA.
- **`gate` ri-scansiona anche i documenti** modificati (non solo il codice): una finalità ad alto rischio può entrare da una spec.
- **`status`** mostra conformità, problemi aperti e **staleness normativa** (avvisa se il corpo `references/` è revisionato da oltre 6 mesi).
- **Riepilogo scan** ordina i problemi per scadenza e gravità; dichiara il confine "vedo solo il repo".
- Parsing dei manifest di dipendenze robusto a rinomini/refusi (per contenuto, non solo per nome).

## [1.1.0] — 2026-08-19

### Aggiunto
- **Scan della documentazione di progetto (SCAN-2b).** Oltre al codice, `/ai-act scan` legge `README*`, `docs/`, `doc/`, `specs/`, `*.md` (root) cercando in linguaggio naturale componenti IA descritti ma non ancora nel codice, finalità dichiarate, termini di dominio ad alto rischio e funzionalità pianificate. I rilievi sono sempre marcati `⚠️ NON VERIFICATO — da documentazione`: alimentano *ignoti* e *Punti di attenzione futuri*, non ottengono mai un'evidenza `file:line` di codice né diventano componenti classificati con obblighi. Nuove sezioni in `01-inventory.md`: "Dichiarato nella documentazione" e "Divergenze codice ↔ documentazione ↔ contesto".
- Placeholder `{{AI_ACT_DOC_PATHS}}` (default `README* docs/ doc/ specs/ *.md`) per configurare i percorsi della documentazione.
- **Uso dual-surface.** La skill `ai-act-check` è ora distribuibile anche come Agent Skill autonoma (app Claude / API / Agent SDK), oltre che dentro il plugin. `scripts/build-skill.sh` impacchetta `skills/ai-act-check/` in `dist/ai-act-check.zip` (struttura conforme: `SKILL.md` alla radice, nome cartella = `name`), con verifica del limite di 1024 caratteri della description. README: sezione "Due modi d'uso" + passi di upload per ogni superficie.
- `description` della skill accorciata a 921/1024 caratteri per conformità Agent Skill (era 1069, oltre il limite).

### Note
- La classificazione e gli obblighi restano fondati **solo** su codice + contesto umano. La documentazione è prosa: mai una fonte di classificazione, solo di segnalazione. Nuova failure-mode "Classificare su un'affermazione della documentazione".

## [1.0.0] — 2026-08-19

Prima release pubblica. Estratta da `claude-infrastructure-template` v2.26.0 e resa autonoma e distribuibile.

### Aggiunto
- Command `/ai-act` con 5 modi: `scan`, `rules`, `docs`, `gate`, `status`.
- Skill `ai-act-check` (autorità legale) con 6 fasi e 11 file `references/`, aggiornati al
  Reg. (UE) 2024/1689 come modificato dal Reg. (UE) 2026/1744 ("Digital Omnibus IA").
- `.claude-plugin/marketplace.json` — installazione pubblica via `/plugin marketplace add giorgiocerruti/ai-act-plugin`.
- `LICENSE` (MIT), `.gitignore`, `CHANGELOG.md`.
- Blocco "Ultima revisione normativa" + cadenza di controllo in `references/fonti-e-strumenti.md`.

### Modificato (rispetto alla copia nel template)
- Default di `AI_ACT_SCAN_PATHS` → repo root: rimossi i placeholder `{{STACK_1_SRC}} {{STACK_2_SRC}}` ereditati dal template, che non si risolvevano fuori dal template.
- `RULES-2` genera la pagina wiki solo se `docs/wiki/` esiste già: un progetto standalone non si vede più creare `docs/wiki/` senza averlo chiesto.
- `plugin.json` — `author` allineato a Giorgio Cerruti.
- README — istruzioni di installazione aggiornate al flusso marketplace.

### Corretto
- `references/indice-articoli.md` — conteggio allegati 13 → 14 (il Digital Omnibus ha aggiunto l'Allegato XIV).
- `references/obblighi-operatori.md` — glifo `10^25` → `10²⁵` FLOP, coerente con gli altri file.
