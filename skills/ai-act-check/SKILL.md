---
name: ai-act-check
description: Valuta la conformità all'AI Act (Reg. UE 2024/1689 come modificato dal Reg. UE 2026/1744) di un sistema di IA: determina il ruolo (fornitore, deployer, terzo fornitore di componenti), la classe di rischio, gli obblighi con le scadenze, le azioni per chi sviluppa e per il cliente, e le clausole contrattuali. Usare quando si valuta un progetto AI in offerta, ci si chiede se un sistema è "ad alto rischio", serve capire se occorre marcatura CE o disclosure di un chatbot, un cliente chiede cosa fare per l'AI Act, si progetta una funzionalità che tocca lavoro, credito, assicurazioni, istruzione, salute o biometria, o si redige un contratto di fornitura di IA. Attivare anche con espressioni come "AI Act", "regolamento europeo sull'intelligenza artificiale", "alto rischio", "Allegato III", "conformità AI", "obblighi trasparenza AI", "AI compliance", "art. 50", "deepfake labeling", "watermark contenuti generati".
---

# AI Act — triage e valutazione di conformità

Valuta un sistema di IA rispetto al Regolamento (UE) 2024/1689, come modificato dal Regolamento (UE) 2026/1744 ("Digital Omnibus IA", in vigore dal 27 luglio 2026).

## Come procedere

Segui le fasi nell'ordine. Non saltare alla conclusione: la classificazione dipende da fatti che vanno raccolti prima.

### Fase 1 — Raccogliere i fatti

Se le informazioni non sono già nel contesto, chiedile. Non inventarle e non dedurle dal nome del progetto.

1. Che cosa fa il sistema, in una frase.
2. Con quale nome o marchio arriva sul mercato, e chi lo mette in servizio.
3. Quali componenti di IA usa (vedi la tassonomia in `references/tipologie-uso.md`).
4. Quali modelli e fornitori a monte.
5. Chi lo usa, e chi è esposto ai suoi output (dipendenti, consumatori, pubblico, minori).
6. Se decide o supporta decisioni riguardanti persone fisiche, e in quale ambito.
7. Quali dati tratta, incluse le categorie particolari dell'art. 9 GDPR.
8. In che stato è: idea, demo su dati fittizi, sviluppo, produzione.

Se un elemento resta ignoto, dillo esplicitamente nell'output e indica come cambierebbe la valutazione nei due scenari.

### Fase 2 — Verificare i divieti (art. 5)

Prima di ogni altra cosa. Se ricorre una pratica vietata, la valutazione si ferma qui: la risposta è che il sistema non si può fare in quella forma. L'elenco completo è in `references/divieti-art5.md`, incluse le due nuove fattispecie applicabili dal 2 dicembre 2026.

Attenzione al meccanismo del nuovo art. 5 §1-bis: chi fornisce un sistema generativo è colpito dal divieto anche quando l'esito vietato è soltanto **ragionevolmente prevedibile e riproducibile senza modifiche tecniche significative** e **mancano misure di sicurezza tecniche ragionevoli e adeguate**. Un generatore di immagini esposto a prompt non filtrati rientra in questa ipotesi.

### Fase 3 — Determinare il ruolo

Se il progetto comporta la modifica di un modello o di un sistema di terzi, leggi prima `references/modifiche-e-ruolo.md`: contiene le quattro vie per cui si diventa fornitore e la soglia di compute (un terzo di quello originario) oltre la quale chi modifica un modello GPAI ne diventa fornitore.

È la determinazione che cambia di più l'esito. Il criterio non è chi scrive il codice, è **con quale nome il sistema arriva sul mercato**.

- **Fornitore** (art. 3 n. 3): sviluppa il sistema o lo fa sviluppare e lo immette sul mercato o lo mette in servizio **con il proprio nome o marchio**.
- **Deployer** (art. 3 n. 4): utilizza il sistema **sotto la propria autorità**.
- **Terzo fornitore di strumenti, servizi, componenti o processi** integrati in un sistema altrui: non è fornitore, ma se il sistema ospite è ad alto rischio è tenuto all'**accordo scritto** dell'art. 25 §4.

Verifica sempre i tre casi di **trasferimento della qualifica di fornitore** dell'art. 25 §1: apposizione del proprio nome o marchio su un sistema ad alto rischio già sul mercato (lett. a, salvi accordi contrattuali di diversa ripartizione); modifica sostanziale (lett. b); **modifica della finalità prevista che rende ad alto rischio un sistema che non lo era, anche un sistema per finalità generali** (lett. c). La lettera c) è quella che colpisce più spesso gli integratori.

Quando la qualifica si trasferisce, il fornitore iniziale resta tenuto a cooperare e a fornire informazioni e accesso tecnico ragionevolmente atteso (art. 25 §2), salvo che abbia espressamente escluso l'uso ad alto rischio.

### Fase 4 — Classificare il rischio

Nell'ordine:

1. **Pratica vietata** → vedi Fase 2.
2. **Alto rischio ex art. 6 §1** — componente di sicurezza di un prodotto disciplinato dalla normativa dell'Allegato I **e** prodotto soggetto a valutazione di conformità di terza parte. Le due condizioni sono **cumulative**: se il prodotto è solo autocertificato, non si applica.
3. **Alto rischio ex art. 6 §2** — il sistema rientra in una delle otto voci dell'Allegato III (`references/allegato-iii.md`).
4. **Deroghe dell'art. 6 §3** — applicabili solo ai sistemi dell'Allegato III, e solo se il sistema **non presenta un rischio significativo** di danno per salute, sicurezza o diritti fondamentali **e** ricorre almeno una fra: compito procedurale limitato; miglioramento del risultato di un'attività umana già completata; rilevamento di schemi o scostamenti decisionali senza sostituire la valutazione umana; compito preparatorio.
   **Knock-out:** un sistema dell'Allegato III che effettua **profilazione di persone fisiche** è **sempre** ad alto rischio; nessuna deroga è invocabile.
   **La deroga non è gratuita:** va documentata prima dell'immissione sul mercato e comporta comunque la registrazione nella banca dati UE (art. 6 §4 e art. 49 §2).
5. **Rischio limitato** — obblighi di trasparenza dell'art. 50 (`references/trasparenza-art50.md`).
6. **Fuori perimetro** — nessun obbligo specifico. Verifica comunque le esclusioni dell'art. 2, in particolare il §8 (ricerca, prova e sviluppo prima dell'immissione sul mercato: copre le demo su dati fittizi, ma **non** le prove in condizioni reali) e il §10 (attività personale non professionale).

Nota che l'art. 4 (alfabetizzazione in materia di IA) si applica a fornitori e deployer **indipendentemente dalla classe di rischio**, dal 2 febbraio 2025.

### Fase 5 — Elencare gli obblighi con le scadenze

Usa `references/scadenzario.md`. Distingui sempre gli obblighi del fornitore da quelli del deployer, e indica per ciascuno la data di applicazione. Le date sono cambiate con il Digital Omnibus: non citare a memoria il calendario originario del 2024.

### Fase 6 — Produrre l'output

Struttura fissa:

1. **Esito in tre righe** — classificazione, ruolo, se c'è o non c'è un'azione urgente.
2. **Fatti su cui si basa la valutazione**, con l'indicazione esplicita di ciò che è rimasto ignoto.
3. **Classificazione**, con la motivazione articolata per articolo.
4. **Ruolo delle parti**, con il richiamo all'art. 25 se rilevante.
5. **Obblighi applicabili** — tabella: obbligo · articolo · chi · scadenza · azione concreta.
6. **Azioni per chi sviluppa.**
7. **Azioni per il cliente**, distinguendo ciò che non può essere assolto al suo posto.
8. **Clausole contrattuali necessarie.**
9. **Punti di attenzione futuri** — quali modifiche del sistema farebbero cambiare classe di rischio. È la sezione più utile: la classificazione è una fotografia, non una garanzia.
10. **Aree adiacenti** — GDPR, Statuto dei lavoratori, Codice del consumo, MDR, dove intersecano. Spesso il rischio concreto è lì.

## Principi da tenere fermi

**La classificazione dipende dalla finalità prevista, non dalla tecnologia.** Lo stesso modello linguistico è fuori perimetro in un assistente documentale e ad alto rischio in uno screening di candidature. Non classificare mai "un LLM": classifica un sistema con una destinazione d'uso.

**Distingui il regolamento dalla prudenza.** Segnala separatamente ciò che è obbligatorio e ciò che consigli come buona prassi. Confonderli fa perdere credibilità e porta il cliente a spendere dove non serve.

**Non allarmare.** La cifra di 35 milioni riguarda le pratiche vietate. Per la trasparenza il massimale è 15 milioni o il 3% del fatturato, e per PMI e piccole imprese a media capitalizzazione si applica **il minore** dei due. Cita la sanzione solo quando è pertinente.

**Il pattern che risolve più problemi è la revisione umana.** Un hold point obbligatorio prima dell'output fa cadere obblighi (l'eccezione editoriale dell'art. 50 §4), attenua la classificazione (art. 6 §3 lett. c) e riduce l'esposizione contrattuale. Quando esiste, documentalo; quando manca e il sistema tocca persone, proponilo.

**Segnala le incertezze.** Molte questioni non hanno ancora orientamenti della Commissione né prassi applicativa. Dove la risposta è incerta, dillo e indica l'interpretazione prudenziale.

**Non è un parere legale.** Chiudi sempre indicando che le decisioni di perimetro e le clausole contrattuali vanno validate da un legale.

## File di riferimento

- `references/scadenzario.md` — calendario consolidato dopo il Digital Omnibus
- `references/allegato-iii.md` — le otto voci dell'Allegato III, con i sottopunti
- `references/divieti-art5.md` — pratiche vietate, incluse le nuove del 2 dicembre 2026
- `references/trasparenza-art50.md` — art. 50 comma per comma, con le eccezioni
- `references/obblighi-operatori.md` — chi deve fare cosa: fornitore, deployer, importatore, distributore
- `references/tipologie-uso.md` — la tassonomia delle componenti di IA e il trattamento di ciascuna
- `references/clausole-contrattuali.md` — struttura dell'addendum contrattuale
- `references/modifiche-e-ruolo.md` — quando una modifica ti rende fornitore; soglie di compute per i modelli GPAI
- `references/annessi-documentali.md` — Allegati IV-IX e XIII: documentazione tecnica, dichiarazione UE, procedure di conformità, registrazione
- `references/indice-articoli.md` — mappa dei 13 Capi, 113 articoli e 14 allegati
- `references/fonti-e-strumenti.md` — quali fonti sono ufficiali e aggiornate, normative adiacenti, misure di favore per le PMI
