# Obblighi degli operatori

Salvo diversa indicazione, gli obblighi elencati per i sistemi ad alto rischio si applicano dal **2 dicembre 2027** (Allegato III) o dal **2 agosto 2028** (Allegato I).

## Fornitore di sistema ad alto rischio — art. 16

a) Garantire la conformità ai requisiti della sezione 2 (artt. 8-15).
b) Indicare nome, denominazione commerciale o marchio registrato e indirizzo di contatto sul sistema, sull'imballaggio o sui documenti di accompagnamento.
c) Disporre di un **sistema di gestione della qualità** conforme all'art. 17.
d) Conservare la documentazione dell'art. 18 (**10 anni**).
e) Conservare i **log** generati automaticamente, quando sotto il proprio controllo (art. 19, **almeno 6 mesi**).
f) Sottoporre il sistema alla **procedura di valutazione della conformità** (art. 43) prima dell'immissione sul mercato.
g) Elaborare la **dichiarazione di conformità UE** (art. 47).
h) Apporre la **marcatura CE** (art. 48).
i) Rispettare gli obblighi di **registrazione** nella banca dati UE (art. 49 §1).
j) Adottare le **misure correttive** e fornire le informazioni dovute (art. 20).
k) Su richiesta motivata di un'autorità, **dimostrare la conformità**.
l) Garantire la conformità ai **requisiti di accessibilità** (direttive 2016/2102 e 2019/882).

### Requisiti sostanziali — artt. 8-15

| Art. | Requisito | Contenuto essenziale |
|---|---|---|
| 9 | Gestione dei rischi | Processo iterativo continuo su tutto il ciclo di vita. Identificazione dei rischi in uso conforme **e in uso improprio ragionevolmente prevedibile**; gerarchia obbligatoria delle misure: eliminazione by design → attenuazione e controllo → informazione e formazione dei deployer. Prove obbligatorie prima dell'immissione, su metriche e soglie definite in anticipo. Attenzione specifica ai minori di 18 anni e ai gruppi vulnerabili. |
| 10 | Dati e governance dei dati | Set di addestramento, convalida e prova **pertinenti, sufficientemente rappresentativi, per quanto possibile esenti da errori e completi**, con proprietà statistiche appropriate. Esame delle distorsioni e misure per individuarle, prevenirle e attenuarle. Documentazione di origine, finalità originaria di raccolta e operazioni di preparazione. Il trattamento di categorie particolari per la correzione dei bias ha ora una base giuridica autonoma nel nuovo **art. 4-bis**. |
| 11 | Documentazione tecnica | Redatta **prima** dell'immissione e tenuta aggiornata; contenuto minimo nell'**Allegato IV**. Regime semplificato per PMI e start-up, con modulo della Commissione che gli organismi notificati devono accettare. |
| 12 | Registrazione degli eventi | Capacità tecnica di **logging automatico per tutta la durata del ciclo di vita**, adeguata alla finalità. Regime rafforzato per l'identificazione biometrica remota. |
| 13 | Trasparenza verso i deployer | **Istruzioni per l'uso** concise, complete, corrette e chiare: identità del fornitore, finalità prevista, **livello di accuratezza dichiarato con le metriche**, circostanze che possono comportare rischi, capacità di spiegazione dell'output, prestazioni su gruppi specifici, specifiche dei dati di input, modifiche predeterminate, misure di sorveglianza umana, risorse necessarie e manutenzione, meccanismi di raccolta e interpretazione dei log. |
| 14 | Sorveglianza umana | Interfacce che consentano una supervisione **efficace**. Il supervisore deve poter comprendere capacità e limiti, restare consapevole della **distorsione dell'automazione**, interpretare correttamente l'output, **decidere di non usare il sistema o ignorare, annullare o ribaltare l'output**, e **interromperlo con un pulsante di arresto**. Per l'identificazione biometrica remota: verifica separata da **almeno due persone**. |
| 15 | Accuratezza, robustezza, cibersicurezza | Livelli dichiarati nelle istruzioni per l'uso. Resilienza a errori, guasti e incongruenze, anche con ridondanza, backup e fail-safe. Per i sistemi che continuano ad apprendere: eliminare o ridurre i **circuiti di feedback** distorsivi. Cibersicurezza contro **data poisoning, model poisoning, esempi antagonistici, evasione dal modello, attacchi alla riservatezza**. |

### Obblighi procedurali collegati

- **Art. 17 — sistema di gestione della qualità:** tredici elementi minimi, dalla strategia di conformità al quadro di responsabilità. **Proporzionato alle dimensioni dell'organizzazione**, senza abbassare il livello di protezione.
- **Art. 18:** conservazione della documentazione per **10 anni**.
- **Art. 19:** conservazione dei log per **almeno 6 mesi**.
- **Art. 20:** misure correttive **immediate** (rendere conforme, ritirare, disabilitare, richiamare) e informazione a distributori, deployer, rappresentante autorizzato e importatori.
- **Art. 72:** monitoraggio successivo all'immissione sul mercato, con piano che fa parte della documentazione tecnica.
- **Art. 73:** segnalazione degli **incidenti gravi** all'autorità di vigilanza del mercato — entro **15 giorni** in via ordinaria, **2 giorni** per infrazioni diffuse o perturbazioni di infrastrutture critiche, **10 giorni** in caso di decesso.

## Deployer di sistema ad alto rischio — art. 26

| § | Obbligo |
|---|---|
| 1 | Misure tecniche e organizzative per usare il sistema **conformemente alle istruzioni per l'uso** |
| 2 | Affidare la **sorveglianza umana a persone con competenza, formazione e autorità necessarie**, e con il sostegno necessario |
| 4 | Garantire che i **dati di input** siano pertinenti e sufficientemente rappresentativi, nella misura in cui si esercita il controllo su di essi |
| 5 | **Monitorare** il funzionamento; se il sistema presenta un rischio ex art. 79 §1, informare senza indebito ritardo fornitore o distributore e l'autorità di vigilanza del mercato e **sospendere l'uso**; in caso di incidente grave informare **immediatamente** |
| 6 | Conservare i **log** sotto il proprio controllo per **almeno 6 mesi** |
| 7 | **Informare i rappresentanti dei lavoratori e i lavoratori interessati prima** di mettere in servizio o utilizzare il sistema sul luogo di lavoro |
| 8 | Se autorità pubblica: obblighi di **registrazione** ex art. 49; **non utilizzare** un sistema che risulti non registrato nella banca dati UE |
| 9 | Usare le informazioni dell'art. 13 per adempiere all'obbligo di **DPIA** ex art. 35 GDPR |
| 11 | **Informare le persone fisiche** che sono soggette all'uso del sistema, quando questo adotta o assiste decisioni che le riguardano (sistemi dell'Allegato III) |
| 12 | **Cooperare** con le autorità competenti |

## FRIA — art. 27

**Chi:** deployer che sono organismi di diritto pubblico o enti privati che forniscono servizi pubblici, e deployer dei sistemi dell'**Allegato III punto 5 lett. b) e c)** (merito di credito; prezzi e rischi di assicurazioni vita e salute). **Escluso** l'Allegato III punto 2 (infrastrutture critiche).

**Contenuto:** processi in cui il sistema sarà usato; periodo e frequenza d'uso; categorie di persone e gruppi interessati; rischi specifici di danno; attuazione delle misure di sorveglianza umana; misure in caso di concretizzazione dei rischi, comprese **governance interna e meccanismi di reclamo**.

**Quando:** al **primo uso**; aggiornabile e riutilizzabile in casi analoghi. I risultati vanno **notificati all'autorità di vigilanza del mercato**. Il Digital Omnibus consente di incorporare o richiamare la DPIA GDPR e prevede un questionario modello dell'Ufficio IA.

## Catena del valore — art. 25

**§1 — Trasferimento della qualifica di fornitore.** Un distributore, importatore, deployer o altro terzo **è considerato fornitore** e assume gli obblighi dell'art. 16 se:
- **a)** appone il proprio nome o marchio su un sistema ad alto rischio già sul mercato — *fatti salvi accordi contrattuali che prevedano una diversa ripartizione*;
- **b)** apporta una **modifica sostanziale** che lascia il sistema ad alto rischio;
- **c)** **modifica la finalità prevista** di un sistema, anche per finalità generali, non classificato ad alto rischio, in modo da renderlo ad alto rischio.

**§2 — Il fornitore iniziale** esce dal ruolo ma deve cooperare strettamente, mettere a disposizione le informazioni necessarie e fornire l'accesso tecnico ragionevolmente atteso — **salvo che abbia chiaramente specificato che il sistema non deve essere trasformato in sistema ad alto rischio**.

**§3 — Fabbricante del prodotto:** per i sistemi che sono componenti di sicurezza di prodotti dell'Allegato I sez. A immessi con il suo nome o marchio, è considerato fornitore.

**§4 — Accordo scritto** fra il fornitore del sistema ad alto rischio e il terzo che fornisce sistemi, strumenti, servizi, componenti o processi integrati: deve precisare informazioni, capacità, accesso tecnico e assistenza necessari. **Esenti** i terzi che rendono accessibili al pubblico strumenti, servizi, processi o componenti con licenza libera e open source (esclusi i modelli GPAI).

## Altri operatori

- **Importatore (art. 23):** verificare valutazione di conformità, documentazione tecnica, marcatura CE, dichiarazione UE, istruzioni per l'uso e nomina del rappresentante autorizzato; non immettere sul mercato in caso di dubbio fondato; identificarsi; conservare per 10 anni.
- **Distributore (art. 24):** verificare marcatura CE, dichiarazione, istruzioni e adempimenti a monte; astenersi in caso di dubbio; adottare misure correttive; cooperare.
- **Rappresentante autorizzato (art. 22):** obbligatorio per i fornitori di paesi terzi, con mandato scritto; cinque compiti minimi, fra cui la conservazione decennale della documentazione; **deve porre fine al mandato** se ritiene che il fornitore violi i propri obblighi.

## Rimedi delle persone interessate

- **Art. 85:** chiunque può presentare **reclamo** all'autorità di vigilanza del mercato.
- **Art. 86:** chi è oggetto di una decisione adottata dal deployer sulla base dell'output di un sistema ad alto rischio dell'Allegato III (escluso il punto 2), che produca effetti giuridici o incida significativamente su salute, sicurezza o diritti fondamentali, ha diritto a **spiegazioni chiare e significative sul ruolo del sistema nella procedura decisionale e sui principali elementi della decisione**.
- **Art. 87:** si applica la direttiva whistleblowing 2019/1937 (in Italia D.lgs. 24/2023).

## Modelli GPAI — artt. 53-55

Obblighi del **fornitore del modello** (non di chi lo usa via API), applicabili dal 2 agosto 2025:

- documentazione tecnica del modello (**Allegato XI**);
- informazioni e documentazione per i **fornitori a valle** (**Allegato XII**);
- **politica sul diritto d'autore**, con rispetto della riserva di diritti ex art. 4 §3 direttiva 2019/790;
- **sintesi pubblica sufficientemente dettagliata dei contenuti di addestramento**, secondo il modello dell'Ufficio IA.

**Esenzione open source:** copre solo le prime due lettere, richiede la pubblicazione effettiva di pesi, architettura e informazioni d'uso, e **decade** per i modelli con rischio sistemico.

**Rischio sistemico** (art. 51): capacità di impatto elevato, presunte oltre **10²⁵ FLOP** cumulativi di addestramento, o designazione della Commissione. Obblighi aggiuntivi dell'art. 55: valutazione con **test contraddittorio (red teaming)**, attenuazione dei rischi sistemici, segnalazione degli incidenti gravi all'Ufficio IA, cibersicurezza del modello e della sua infrastruttura.

**Se usi modelli di terzi via API non sei fornitore GPAI.** Lo diventi se immetti sul mercato un modello che hai addestrato o modificato in modo significativo. In quanto fornitore a valle hai però diritto, ex art. 53 §1 lett. b), a ricevere dal fornitore del modello le informazioni necessarie ad adempiere ai tuoi obblighi: archiviarle è parte del fascicolo di conformità.
