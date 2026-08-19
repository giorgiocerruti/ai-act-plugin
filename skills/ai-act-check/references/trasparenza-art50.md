# Art. 50 — Obblighi di trasparenza

**Applicabile dal 2 agosto 2026**, tutti i commi. Unica finestra: la marcatura del §2 per i sistemi generativi già sul mercato prima di quella data ha tempo fino al **2 dicembre 2026** (nuovo art. 111 §4).

Sanzione: fino a **15 M€ o il 3%** del fatturato mondiale annuo, il maggiore (per PMI e piccole imprese a media capitalizzazione: il minore).

## §1 — Chatbot e sistemi che interagiscono con persone
**Obbligato: il FORNITORE.**

> "I fornitori garantiscono che i sistemi di IA destinati a interagire direttamente con le persone fisiche sono progettati e sviluppati in modo tale che le persone fisiche interessate siano informate del fatto di stare interagendo con un sistema di IA, a meno che ciò non risulti evidente dal punto di vista di una persona fisica ragionevolmente informata, attenta e avveduta, tenendo conto delle circostanze e del contesto di utilizzo."

- È un obbligo **di progettazione**, non una clausola nei termini di servizio.
- **Eccezione dell'evidenza**: valutata secondo lo standard della persona ragionevolmente informata, attenta e avveduta, **nel contesto specifico**. Un widget etichettato "Assistente AI" dentro una dashboard professionale è probabilmente coperto; una risposta automatica su WhatsApp a chi crede di scrivere all'azienda no.
- **Eccezione law enforcement**: sistemi autorizzati dalla legge per accertare, prevenire, indagare o perseguire reati — salvo che siano a disposizione del pubblico per segnalare un reato.

**Regola pratica:** fare la disclosure sempre. Costa una riga di interfaccia ed elimina la discussione sull'evidenza.

## §2 — Contenuti sintetici
**Obbligato: il FORNITORE**, compresi i fornitori di sistemi di IA per finalità generali.

> Gli output di sistemi che generano "contenuti audio, immagine, video o testuali sintetici" devono essere **marcati in un formato leggibile meccanicamente e rilevabili come generati o manipolati artificialmente**. Le soluzioni tecniche devono essere "efficaci, interoperabili, solide e affidabili nella misura in cui ciò sia tecnicamente possibile", tenendo conto dei tipi di contenuto, dei costi di attuazione e dello stato dell'arte.

- **Non basta l'etichetta visibile.** Serve una marcatura tecnica: metadati C2PA / Content Credentials, watermark, o equivalente.
- **Attenzione alla pipeline:** se il tuo flusso rimuove i metadati apposti a monte dal fornitore del modello, l'inadempimento diventa tuo.
- **Eccezioni:** il sistema svolge "una funzione di assistenza per l'editing standard"; oppure "non modifica in modo sostanziale i dati di input forniti dal deployer o la rispettiva semantica"; oppure è autorizzato dalla legge a fini di contrasto.
  - *Rientrano nell'eccezione:* correttori ortografici e grammaticali, riformulatori che non alterano la sostanza informativa. Gli orientamenti della Commissione del 22 luglio 2026 leggono l'eccezione in modo **restrittivo**.
  - *Non rientrano:* generazione di un post, di un'immagine, di un report da zero.
  - **Fuori dall'ambito oggettivo del §2** (questione diversa dall'eccezione): il **codice sorgente**, le sequenze brevi di simboli e gli output macchina-macchina non destinati alla percezione umana. Il codice generato non va marcato — ma la ragione è l'ambito, non l'editing assistito.

## §3 — Riconoscimento emozioni e categorizzazione biometrica
**Obbligato: il DEPLOYER.**

Informare le persone fisiche esposte in merito al funzionamento del sistema, e trattare i dati personali conformemente a GDPR, Reg. 2018/1725 e direttiva 2016/680. Eccezione per l'uso autorizzato dalla legge a fini di contrasto.

## §4 primo comma — Deep fake
**Obbligato: il DEPLOYER.**

Chi usa un sistema che genera o manipola immagini, audio o video costituenti un **deep fake** — contenuto che assomiglia a persone, oggetti, luoghi, entità o eventi **esistenti** e apparirebbe falsamente autentico — deve **rendere noto che il contenuto è stato generato o manipolato artificialmente**.

- **Eccezione artistica:** se il contenuto fa parte di "un'analoga opera o di un programma manifestamente artistici, creativi, satirici o fittizi", l'obbligo si riduce a rivelare l'esistenza del contenuto "in modo adeguato, senza ostacolare l'esposizione o il godimento dell'opera". È un'attenuazione modale, **non un'esenzione**.
- Eccezione per l'uso autorizzato dalla legge a fini di contrasto.

## §4 secondo comma — Testo di interesse pubblico
**Obbligato: il DEPLOYER.**

Chi pubblica **testo generato o manipolato dall'IA allo scopo di informare il pubblico su questioni di interesse pubblico** deve renderlo noto.

- **Eccezione editoriale, cumulativa:** l'obbligo non si applica se il contenuto è stato sottoposto a **revisione umana o controllo editoriale** **e** una persona fisica o giuridica **detiene la responsabilità editoriale** della pubblicazione. Servono entrambi.
- **Il marketing commerciale ordinario non è "interesse pubblico".** Lo sono l'informazione su temi civici, sanitari, elettorali, di sicurezza.

> Un workflow con approvazione umana obbligatoria prima della pubblicazione fa cadere questo obbligo. **Documentare quel workflow è la prova della conformità.**

## §5 — Modalità e tempi

Le informazioni dei §§1-4 sono fornite "in maniera chiara e distinguibile **al più tardi al momento della prima interazione o esposizione**" e devono rispettare i **requisiti di accessibilità** applicabili.

## §6 — Rapporto con altri obblighi

I §§1-4 lasciano impregiudicati i requisiti del Capo III (alto rischio) e gli altri obblighi di trasparenza previsti dal diritto dell'Unione o nazionale. La conformità all'art. 50 non esaurisce la trasparenza dovuta ai sensi del GDPR.

## §7 — Codici di buone pratiche

L'Ufficio per l'IA agevola l'elaborazione di codici di buone pratiche sulla rilevazione e l'etichettatura dei contenuti generati o manipolati artificialmente. Il Digital Omnibus ha ridotto il potere della Commissione a competenza residuale, esercitabile solo se il codice risulta inadeguato. La Commissione ha pubblicato orientamenti sulla trasparenza il **22 luglio 2026**, accompagnati da un codice volontario e da un set di icone standardizzate.

---

# Checklist rapida

| Il sistema… | Obbligo | Chi | Da quando |
|---|---|---|---|
| dialoga con persone fisiche | disclosure alla prima interazione | fornitore | 2 ago 2026 |
| genera testo, immagini, audio o video destinati alla fruizione | marcatura leggibile a macchina | fornitore | 2 ago 2026 (2 dic 2026 se già sul mercato) |
| riconosce emozioni o categorizza biometricamente | informativa alle persone esposte | deployer | 2 ago 2026 |
| produce deep fake | dichiarazione di contenuto artificiale | deployer | 2 ago 2026 |
| pubblica testo su questioni di interesse pubblico | dichiarazione — salvo revisione umana con responsabilità editoriale | deployer | 2 ago 2026 |
| assiste l'editing senza alterare sostanzialmente l'input | nessuno | — | — |
| genera codice sorgente o output macchina-macchina | nessuno — fuori dall'ambito oggettivo del §2 | — | — |
