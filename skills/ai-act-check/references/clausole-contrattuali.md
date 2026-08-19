# Addendum contrattuale AI Act — struttura

Da allegare ai contratti di fornitura, sviluppo o integrazione di sistemi di IA. Otto clausole. **Struttura, non redazione: il testo va validato da un legale.**

## 1. Qualificazione delle parti

Individuazione espressa di chi è **fornitore** (art. 3 n. 3) e chi **deployer** (art. 3 n. 4), con la precisazione — dove è così — che il sistema è messo in servizio con il nome e sotto l'autorità del cliente.

*Funzione:* evitare che la qualifica di fornitore venga attribuita per default a chi ha scritto il codice. In assenza di clausola, un'autorità che vede il logo dello sviluppatore, la sua infrastruttura e il suo dominio concluderà che il fornitore è lui.

## 2. Finalità prevista

Descrizione puntuale della finalità ai sensi dell'art. 3 n. 12, e dichiarazione che il sistema **non è destinato** agli usi dell'Allegato III.

*Funzione:* fissare il parametro rispetto al quale si misura una eventuale "modifica della finalità prevista" ex art. 25 §1 lett. c). Senza una finalità scritta, non c'è modo di dimostrare che il cliente l'ha cambiata.

## 3. Divieto di uso non conforme

Il cliente si obbliga a non destinare il sistema a finalità dell'Allegato III o vietate dall'art. 5 senza previo accordo scritto, e **riconosce espressamente** che una destinazione difforme comporta l'assunzione in capo a sé della qualifica di fornitore ai sensi dell'art. 25 §1 lett. c), con tutti gli obblighi dell'art. 16.

*Funzione:* è la clausola che protegge di più. Richiama, in chiave contrattuale, la stessa logica dell'art. 25 §2, che libera il fornitore iniziale quando questi abbia "chiaramente specificato che il suo sistema di IA non deve essere trasformato in un sistema di IA ad alto rischio".

**Per i prodotti configurabili dal cliente** (piattaforme generiche, sistemi che si auto-configurano su database del cliente) la clausola va rafforzata con un elenco espresso degli usi esclusi: valutazione o selezione del personale, monitoraggio delle prestazioni individuali, merito di credito, prezzi assicurativi vita e salute, accesso a servizi essenziali, istruzione, biometria. Dove tecnicamente possibile, va accompagnata da un controllo nel prodotto.

## 4. Modifiche e rebranding

Obbligo di preavviso scritto per le **modifiche sostanziali** (art. 3 n. 23) e per l'apposizione di un marchio diverso. Richiamo espresso all'art. 25 §1 lett. a) e b), con l'indicazione — nella misura consentita — della diversa ripartizione degli obblighi.

*Funzione:* governa il caso del partner che rivende il prodotto con il proprio marchio. L'art. 25 §1 lett. a) fa salvi gli "accordi contrattuali che prevedano una diversa ripartizione degli obblighi": senza accordo, la qualifica si trasferisce automaticamente a chi appone il marchio.

## 5. Cooperazione, informazioni e assistenza tecnica

Impegno reciproco a fornire informazioni, accesso tecnico ragionevolmente atteso e assistenza ai sensi dell'art. 25 §§2 e 4, **con perimetro definito e corrispettivo** per le attività che eccedono l'ordinario.

*Funzione:* l'art. 25 §2 impone un dovere di cooperazione che, senza limiti contrattuali, si traduce nell'obbligo di fare gratuitamente e a tempo indefinito il lavoro documentale di un cliente salito in classe di rischio.

## 6. Trasparenza (art. 50)

Ripartizione degli adempimenti: il fornitore implementa le funzionalità tecniche (disclosure del chatbot, marcatura dei contenuti sintetici, meccanismi di etichettatura); il deployer approva i testi e risponde della trasparenza verso i propri interlocutori.

*Funzione:* l'art. 50 distribuisce gli obblighi fra §§1-2 (fornitore) e §§3-4 (deployer). Senza ripartizione contrattuale ciascuno presume che se ne occupi l'altro.

## 7. Modelli e componenti di terzi

Elenco dei modelli e dei fornitori a monte, con richiamo alle rispettive **policy di uso accettabile**, e limitazione di responsabilità per il comportamento del modello di terzi nei limiti consentiti dalla legge.

*Funzione:* i fornitori di modelli escludono contrattualmente determinati usi. Quelle esclusioni si trasmettono al cliente finale e vanno rese note: promettere un caso d'uso vietato dalla policy del fornitore a monte espone due volte.

## 8. Dati, log e sicurezza

Raccordo con il DPA ex art. 28 GDPR: titolarità e ruoli, **conservazione dei log** (predisporre il periodo minimo di sei mesi anche prima che diventi obbligatorio ex artt. 19 e 26 §6), gestione e notifica degli incidenti, canale di segnalazione, misure di sicurezza.

---

## Clausole aggiuntive per i sistemi che diventano ad alto rischio

Se il sistema è o diventa ad alto rischio, all'addendum vanno aggiunti:

- **Accordo scritto ex art. 25 §4** con i terzi che forniscono strumenti, servizi, componenti o processi integrati — obbligatorio, non facoltativo. Deve precisare informazioni, capacità, accesso tecnico e assistenza necessari, sulla base dello stato dell'arte generalmente riconosciuto. L'Ufficio per l'IA può pubblicare clausole tipo volontarie.
- **Impegni sul sistema di gestione della qualità** (art. 17) e sulla documentazione tecnica (art. 11 e Allegato IV), con l'indicazione di chi la redige e la mantiene aggiornata.
- **Conservazione decennale** della documentazione (art. 18) e ripartizione dell'onere.
- **Procedura di segnalazione degli incidenti gravi** (art. 73), con i termini di 15, 10 e 2 giorni e l'individuazione di chi notifica.
- **Impegno del deployer** ad adempiere agli obblighi dell'art. 26, con particolare riguardo all'informativa ai rappresentanti dei lavoratori (§7) e alle persone soggette a decisioni (§11).
- **Cooperazione sulla FRIA** (art. 27) dove il deployer vi sia tenuto.
- **Gestione del diritto alla spiegazione** (art. 86): chi risponde alla richiesta della persona interessata e con quale supporto tecnico.
