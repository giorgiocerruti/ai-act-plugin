# Tipologie d'uso e trattamento nell'AI Act

Tassonomia da usare in fase di raccolta dei fatti. Per ciascuna componente: che cosa dice il regolamento e dove sta il confine.

## Generazione di testo
Non regolata in sé. Contano la destinazione e la pubblicazione.
- **Art. 50 §2 (fornitore):** marcatura leggibile a macchina degli output. Eccezione per l'assistenza all'editing standard e per i sistemi che non modificano sostanzialmente input o semantica.
- **Art. 50 §4 c. 2 (deployer):** testo pubblicato per informare il pubblico su questioni di interesse pubblico. **L'eccezione della revisione umana con responsabilità editoriale fa cadere l'obbligo.** Il marketing commerciale non è interesse pubblico.

## Generazione di immagini, video, audio
La categoria più regolata, e l'unica con divieti assoluti.
- **Art. 50 §2:** marcatura tecnica (C2PA, watermark). Non basta l'etichetta visibile. Verificare che la pipeline non rimuova i metadati apposti a monte.
- **Art. 50 §4 c. 1:** i deep fake — contenuti che assomigliano a persone, luoghi o eventi **esistenti** — vanno dichiarati. Eccezione attenuata per opere manifestamente artistiche, creative, satiriche o fittizie.
- **Art. 5 lett. b-bis e b-ter (dal 2 dic 2026):** divieto di contenuti intimi non consensuali e di CSAM. Il fornitore risponde anche per esiti solo prevedibili in assenza di misure di sicurezza ragionevoli → **filtri di contenuto obbligatori** sui generatori esposti a input non controllati.

## Generazione di codice
Il caso più leggero. Nessuna voce dell'Allegato III. **Non serve marcare il codice generato**, perché il codice sorgente è fuori dall'ambito oggettivo dell'art. 50 §2 (contenuti non destinati alla percezione umana), secondo gli orientamenti della Commissione del 22 luglio 2026. La ragione non è l'eccezione dell'editing assistito, che è letta restrittivamente e non coprirebbe la generazione *ex novo*. Restano rilevanti, fuori dall'AI Act, le licenze, la sicurezza del codice prodotto e la responsabilità contrattuale per gli agenti che scrivono su repository altrui.

## Chatbot e assistenti conversazionali
- **Art. 50 §1 (fornitore):** obbligo di **design** — l'utente deve sapere che sta parlando con un'IA, al più tardi alla prima interazione.
- L'eccezione dell'evidenza si valuta nel contesto: un widget etichettato in una dashboard professionale è coperto, una risposta automatica a chi crede di scrivere a una persona no.
- Se il chatbot tratta dati personali o profila: informativa GDPR, base giuridica, eventualmente art. 22.

## Agenti autonomi (agentic AI)
**Non esiste una categoria "agente" nell'AI Act.** Il Digital Omnibus lo nomina per la prima volta nell'Allegato XIV (codice AIH 0401, "tecnologie emergenti, compresa l'IA agentica") ma senza definizione né obblighi. Un agente si classifica per **ciò che fa**.

Ciò che cambia in pratica:
- **Art. 14** (se alto rischio): più autonomia significa misure di sorveglianza più robuste — comprensione dei limiti, consapevolezza della distorsione dell'automazione, potere di ignorare o ribaltare l'output, pulsante di arresto.
- **Art. 15** (se alto rischio): la prompt injection su un agente con strumenti di scrittura è esattamente lo scenario di "evasione dal modello" ed "esempi antagonistici" previsto dalla norma.
- **Artt. 12, 19, 26 §6:** un agente multi-step senza log delle decisioni non è difendibile. Predisporre la conservazione già prima che diventi obbligatoria.
- Gli **hold point human-in-the-loop** sono la difesa migliore: fanno cadere obblighi, attenuano la classificazione e riducono l'esposizione contrattuale.

## RAG e ricerca documentale
Non regolato di per sé. Diventa rilevante quando l'output alimenta una decisione su persone (conta la decisione) o quando la knowledge base contiene dati personali (GDPR: base giuridica, minimizzazione, cancellazione **anche dagli indici vettoriali** — punto sistematicamente dimenticato).

## Classificazione, scoring, profilazione di persone
Qui si decide l'alto rischio. Tre livelli:
1. **Vietato:** social scoring (art. 5 lett. c), predizione di reati su sola profilazione (d), emozioni sul lavoro e a scuola (f), categorizzazione biometrica su caratteristiche protette (g).
2. **Alto rischio:** merito di credito (All. III 5.b, escluso l'antifrode), prezzi e rischi di assicurazioni vita e salute (5.c), selezione e valutazione dei lavoratori (4), ammissibilità a prestazioni pubbliche (5.a), triage di emergenze (5.d).
3. **Non regolato:** scoring commerciale B2B, qualificazione dei lead, priorità dei ticket.

**Knock-out:** se il sistema rientra in una voce dell'Allegato III **e** profila persone fisiche, è sempre ad alto rischio.

## Previsione e forecasting
Su grandezze aziendali: fuori perimetro. Su persone, con decisione in una delle categorie dell'Allegato III: alto rischio.
Rischio adiacente frequente: presentare come "previsione AI" un output calcolato su dati fittizi o su una media mobile è una pratica commerciale potenzialmente ingannevole (Codice del consumo, artt. 20-23).

## Computer vision, OCR, document AI
- Estrazione da documenti (fatture, DDT, capitolati): fuori perimetro, anche se dietro c'è un LLM.
- Lettura targhe: trattamento di dati personali, **non** biometria ai sensi dell'AI Act.
- Riconoscimento facciale: territorio dell'Allegato III punto 1 e, in alcune configurazioni, dei divieti dell'art. 5.
- Classificazione automatica di documenti con punteggio di confidenza e revisione umana: fuori perimetro, ma è già la struttura che l'art. 14 richiederebbe. Documentarla.

## Biometria e riconoscimento delle emozioni
Il territorio più duro. Vedi `divieti-art5.md` e `allegato-iii.md` punto 1. Da non affrontare senza una valutazione dedicata. Obbligo di informativa dell'art. 50 §3 in capo al deployer dal 2 agosto 2026.

## Raccomandazione e personalizzazione
Fuori perimetro AI Act; dentro DSA (per le piattaforme), GDPR e Codice del consumo. Il limite è l'art. 5 lett. a) e b) quando il sistema è tarato su utenti vulnerabili. I sistemi integrati in VLOP/VLOSE designate ai sensi del DSA passano alla competenza esclusiva dell'Ufficio IA (nuovo art. 75).

## Ambiti che cambiano la classificazione a parità di tecnologia

| Ambito | Effetto |
|---|---|
| **Lavoro** | Allegato III punto 4. La lettera b) copre anche assegnazione di compiti e monitoraggio delle prestazioni. Sempre rilevante l'art. 4 L. 300/1970, anche senza AI. |
| **Credito e assicurazioni** | Allegato III punto 5 b) e c). Antifrode esclusa. FRIA obbligatoria anche per soggetti privati. Autorità competente: vigilanza finanziaria. |
| **Istruzione** | Allegato III punto 3, incluso il proctoring. |
| **Sanità** | Tre binari distinti: gestionale sanitario = fuori perimetro; software dispositivo medico = art. 6 §1 (dal 2 ago 2028); triage e ammissibilità a prestazioni = Allegato III punto 5 a) e d). |
| **Minori** | Non è una categoria autonoma, ma l'art. 9 §9 impone attenzione specifica agli under 18 nella gestione dei rischi, e l'art. 5 lett. b) vieta lo sfruttamento delle vulnerabilità legate all'età. |
| **Settore pubblico** | Obblighi di registrazione ex art. 49 §3 e FRIA ex art. 27 in capo al deployer. |

## Esclusioni dall'ambito (art. 2)

- **§3** — scopi militari, di difesa o di sicurezza nazionale.
- **§6** — sistemi sviluppati e messi in servizio **al solo scopo di ricerca e sviluppo scientifici**.
- **§8** — attività di **ricerca, prova o sviluppo prima dell'immissione sul mercato**. Copre le demo su dati fittizi. **Non copre le prove in condizioni reali.**
- **§10** — deployer persone fisiche in attività non professionale puramente personale.
- **§12** — sistemi rilasciati con licenza libera e open source, **salvo** che siano immessi come sistemi ad alto rischio o rientrino negli artt. 5 o 50.
