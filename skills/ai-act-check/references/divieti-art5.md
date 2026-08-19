# Art. 5 — Pratiche di IA vietate

Applicabili dal **2 febbraio 2025**; le lettere b-bis e b-ter dal **2 dicembre 2026**.

Se una di queste ipotesi ricorre, la valutazione si ferma: il sistema non si può fare in quella forma. Sanzione fino a **35 M€ o il 7%** del fatturato mondiale annuo (il maggiore; per PMI il minore).

## a) Tecniche subliminali, manipolative o ingannevoli

Immissione, messa in servizio o uso di un sistema che usa **tecniche subliminali** che agiscono senza che la persona ne sia consapevole, o tecniche **volutamente manipolative o ingannevoli**, aventi lo scopo o l'effetto di **distorcere materialmente il comportamento** di una persona o di un gruppo, pregiudicandone in modo considerevole la capacità di prendere una decisione informata, e inducendola a una decisione che non avrebbe altrimenti preso, in un modo che provochi o possa ragionevolmente provocare **un danno significativo**.

*Soglia alta: servono cumulativamente la tecnica manipolativa, la distorsione materiale e il danno significativo. Non basta la persuasione commerciale ordinaria.*

## b) Sfruttamento di vulnerabilità

Sfruttamento delle vulnerabilità dovute a **età, disabilità o a una specifica situazione sociale o economica**, con l'obiettivo o l'effetto di distorcere materialmente il comportamento in un modo che provochi o possa ragionevolmente provocare un danno significativo.

## b-bis) Contenuti intimi non consensuali *(nuova — dal 2 dicembre 2026)*

Generazione o manipolazione di **immagini, video o audio realistici** raffiguranti **parti intime o attività sessualmente esplicite di persone identificabili**, senza consenso **libero, specifico, informato, inequivocabile ed esplicito**.

## b-ter) Materiale pedopornografico *(nuova — dal 2 dicembre 2026)*

Generazione di materiale ai sensi dell'art. 2 lett. c) ed e) della direttiva 2011/93/UE. Esimente "senza diritto" per attività legittime di law enforcement, indagine penale e red-teaming o valutazione dei modelli.

### Come si applicano b-bis e b-ter (nuovo art. 5 §§1-bis, 1-ter, 1-quater)

- **Fornitore:** il divieto scatta se la generazione di quel materiale è la **finalità prevista**, **oppure** se l'esito è **ragionevolmente prevedibile e riproducibile senza modifiche tecniche significative** **e** mancano **misure di sicurezza tecniche ragionevoli e adeguate**.
- **Deployer:** il divieto copre soltanto l'**uso intenzionale** per generare tale materiale.
- **Safe harbour (§1-ter):** manipolazioni che non aumentano l'esposizione di parti intime né alterano la natura dell'attività raffigurata.
- **Esclusioni (§1-quater):** contenuti caricaturali o fisicamente impossibili, opere artistiche non realistiche, applicazioni di prova virtuale di capi di abbigliamento, applicazioni mediche.

> **Conseguenza operativa:** chiunque fornisca un sistema di generazione di immagini esposto a input non controllati deve implementare filtri di contenuto in ingresso e in uscita entro il 2 dicembre 2026. L'assenza di intento non protegge.
>
> In Italia si aggiunge l'**art. 612-quater c.p.** (L. 132/2025): illecita diffusione di contenuti generati o alterati con IA, idonei a indurre in inganno sulla genuinità e produttivi di danno ingiusto — reclusione da 1 a 5 anni.

## c) Social scoring

Valutazione o classificazione di persone fisiche o gruppi **per un determinato periodo di tempo** sulla base del **comportamento sociale** o di caratteristiche personali o della personalità note, inferite o previste, quando il punteggio comporta:

- **i)** trattamento pregiudizievole o sfavorevole in **contesti sociali scollegati** da quelli in cui i dati sono stati originariamente generati o raccolti; oppure
- **ii)** trattamento pregiudizievole o sfavorevole **ingiustificato o sproporzionato** rispetto al comportamento sociale o alla sua gravità.

*Lo scoring commerciale ordinario (merito di credito, rischio assicurativo) non è vietato: è disciplinato come alto rischio nell'Allegato III punto 5.*

## d) Predizione di reati basata solo su profilazione

Valutazioni del rischio che una persona fisica commetta un reato, **unicamente sulla base della profilazione** o della valutazione dei tratti e delle caratteristiche della personalità.

**Non vietati** i sistemi a sostegno della valutazione umana del coinvolgimento in un'attività criminosa, quando questa si basa già su **fatti oggettivi e verificabili** direttamente connessi a un'attività criminosa.

## e) Scraping non mirato di volti

Creazione o ampliamento di banche dati di riconoscimento facciale mediante **scraping non mirato** di immagini facciali da internet o da filmati di telecamere a circuito chiuso.

## f) Riconoscimento delle emozioni sul lavoro e a scuola

Inferire le emozioni di una persona fisica **nell'ambito del luogo di lavoro e degli istituti di istruzione**, salvo che il sistema sia destinato a essere messo in funzione o immesso sul mercato per **motivi medici o di sicurezza**.

*Fuori da questi due contesti il riconoscimento delle emozioni non è vietato, ma è alto rischio (Allegato III punto 1 lett. c) e comporta l'obbligo di informativa dell'art. 50 §3.*

## g) Categorizzazione biometrica su caratteristiche protette

Sistemi di categorizzazione biometrica che classificano individualmente le persone sulla base dei dati biometrici per dedurre **razza, opinioni politiche, appartenenza sindacale, convinzioni religiose o filosofiche, vita sessuale o orientamento sessuale**.

**Non vietati** l'etichettatura e il filtraggio di set di dati biometrici acquisiti legalmente, né la categorizzazione di dati biometrici nel settore delle attività di contrasto.

## h) Identificazione biometrica remota "in tempo reale" in spazi pubblici a fini di contrasto

Vietata **salvo** che sia strettamente necessaria per: ricerca mirata di vittime di sottrazione, tratta o sfruttamento sessuale e di persone scomparse; prevenzione di una minaccia specifica, sostanziale e imminente per la vita o l'incolumità fisica, o di un attacco terroristico; localizzazione o identificazione di un sospettato per i reati dell'Allegato II punibili con almeno quattro anni.

Anche nei casi ammessi servono: valutazione di necessità e proporzionalità, **autorizzazione preventiva** di un'autorità giudiziaria o amministrativa indipendente (in urgenza, richiesta entro 24 ore), **FRIA** ex art. 27, **registrazione** nella banca dati UE, notifica all'autorità di vigilanza del mercato e al Garante privacy, relazioni annuali. Nessuna decisione con effetti giuridici negativi può essere presa unicamente sulla base dell'output.

---

**Clausola di chiusura (art. 5 §8):** l'articolo lascia impregiudicati i divieti derivanti da altre disposizioni del diritto dell'Unione. Un sistema non vietato dall'art. 5 può esserlo altrove — GDPR, direttiva 2016/680, normativa consumeristica, diritto del lavoro.
