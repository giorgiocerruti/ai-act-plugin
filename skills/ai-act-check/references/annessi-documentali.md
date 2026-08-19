# Allegati documentali e procedure di conformità

Serve quando un sistema è (o sta per diventare) ad alto rischio. Applicazione: **2 dicembre 2027** per l'Allegato III, **2 agosto 2028** per l'Allegato I.

## Quadro di sintesi

| Allegato | Oggetto | Chi lo produce | Quando | Articolo |
|---|---|---|---|---|
| **IV** | Documentazione tecnica | Fornitore | **Prima** dell'immissione sul mercato; tenuta aggiornata; conservata **10 anni** | art. 11, art. 18 |
| **V** | Dichiarazione di conformità UE | Fornitore, sotto responsabilità esclusiva | Al termine della valutazione di conformità; conservata 10 anni | art. 47 |
| **VI** | Valutazione della conformità **basata sul controllo interno** | Fornitore, **senza organismo notificato** | Prima dell'immissione; ripetuta a ogni modifica sostanziale | art. 43 §2 |
| **VII** | Conformità basata su valutazione del **SGQ** e della documentazione tecnica | Fornitore **+ organismo notificato** | Prima dell'immissione **e in continuo** | art. 43 §1 |
| **VIII** | Informazioni per la registrazione nella banca dati UE | Fornitore (sez. A e B), deployer pubblici (sez. C) | Prima dell'immissione / dell'uso | art. 49 |
| **IX** | Registrazione delle prove in condizioni reali | Fornitore o potenziale fornitore | Prima delle prove | art. 60 |
| **XIII** | Criteri per designare un modello GPAI con rischio sistemico | Commissione | — | art. 51 |

**Regola di scelta della procedura (art. 43):** per l'**Allegato III punto 1 (biometria)** il fornitore sceglie fra Allegato VI e VII, ma deve usare l'**Allegato VII** se non ha applicato integralmente le norme armonizzate (o non esistono). Per l'**Allegato III punti 2-8** si applica sempre l'**Allegato VI** (controllo interno, senza organismo notificato). Per i sistemi dell'**Allegato I** si segue la procedura dell'atto settoriale.

---

## ALLEGATO IV — Documentazione tecnica (checklist)

Regime semplificato per **PMI e start-up**: possono fornire gli elementi in forma semplificata, secondo il modulo della Commissione, che gli organismi notificati devono accettare (art. 11 §1, terzo comma).

**1. Descrizione generale del sistema**
- ☐ finalità prevista, nome del fornitore, versione e rapporto con le versioni precedenti
- ☐ interazione con hardware o software non facenti parte del sistema, **compresi altri sistemi di IA**
- ☐ versioni di software e firmware e requisiti di aggiornamento
- ☐ tutte le forme in cui è immesso sul mercato: pacchetti incorporati nell'hardware, download, **API**
- ☐ hardware su cui è destinato a operare
- ☐ fotografie o illustrazioni, se componente di prodotti
- ☐ descrizione di base dell'interfaccia utente fornita al deployer
- ☐ istruzioni per l'uso destinate al deployer

**2. Descrizione dettagliata degli elementi e del processo di sviluppo**
- ☐ metodi e azioni di sviluppo, **compreso il ricorso a sistemi o strumenti preaddestrati forniti da terzi** e il modo in cui sono stati utilizzati, integrati o modificati
- ☐ specifiche di progettazione: logica generale, algoritmi, principali scelte di progettazione **con motivazioni e ipotesi**, scelte di classificazione, aspetti che il sistema ottimizza, output atteso, **compromessi adottati** per soddisfare i requisiti
- ☐ architettura del sistema e risorse computazionali usate per sviluppo, addestramento, prova e convalida
- ☐ requisiti in materia di dati, con **schede tecniche** su metodologie di addestramento e set di dati: origine, ambito, caratteristiche principali, modalità di ottenimento e selezione, procedure di etichettatura, metodologie di pulizia e rilevamento di valori anomali
- ☐ valutazione delle misure di sorveglianza umana ex art. 14, incluse le misure tecniche per facilitare l'interpretazione degli output
- ☐ modifiche predeterminate del sistema e delle prestazioni, con le soluzioni tecniche che garantiscono la conformità costante
- ☐ procedure di convalida e prova, metriche di accuratezza e robustezza, **impatti potenzialmente discriminatori**, log delle prove e **relazioni di prova datate e firmate**
- ☐ misure di cibersicurezza

**3. Monitoraggio, funzionamento e controllo**
- ☐ capacità e limitazioni delle prestazioni, **con i gradi di accuratezza per specifiche persone o gruppi** e il livello complessivo atteso
- ☐ risultati indesiderati prevedibili e fonti di rischio per salute, sicurezza e diritti fondamentali, **incluso il rischio di discriminazione**
- ☐ misure di sorveglianza umana
- ☐ specifiche dei dati di input

**4.** ☐ Adeguatezza delle metriche di prestazione — non basta elencarle, va **giustificata la scelta**
**5.** ☐ Descrizione dettagliata del sistema di gestione dei rischi (art. 9)
**6.** ☐ Modifiche apportate durante il ciclo di vita — implica un **changelog di conformità**
**7.** ☐ Norme armonizzate applicate; se non applicate, **descrizione dettagliata delle soluzioni adottate**
**8.** ☐ Copia della dichiarazione di conformità UE (Allegato V)
**9.** ☐ Sistema di valutazione delle prestazioni post-immissione (art. 72), **incluso il piano di monitoraggio**

---

## ALLEGATO V — Dichiarazione di conformità UE

Otto elementi obbligatori:

1. ☐ nome e tipo del sistema, con riferimento inequivocabile che ne consenta identificazione e tracciabilità
2. ☐ nome e indirizzo del fornitore o del rappresentante autorizzato
3. ☐ attestazione che la dichiarazione è rilasciata **sotto la responsabilità esclusiva del fornitore**
4. ☐ attestazione di conformità al regolamento e alle altre disposizioni UE che richiedono una dichiarazione
5. ☐ se il sistema tratta dati personali, dichiarazione di conformità a GDPR, Reg. 2018/1725 e direttiva 2016/680
6. ☐ riferimenti alle norme armonizzate o alle specifiche comuni applicate
7. ☐ ove applicabile, nome e numero di identificazione dell'organismo notificato, procedura applicata, certificato rilasciato
8. ☐ luogo e data, nome e funzione del firmatario, indicazione della persona per conto della quale firma, firma

> Il **punto 7 è il discriminante di procedura**: se compilato, si è seguito l'Allegato VII; se assente, l'Allegato VI.

---

## ALLEGATO VI — Controllo interno (autovalutazione)

Tre passaggi operativi, senza organismo notificato:

1. ☐ **Verificare la conformità del sistema di gestione della qualità** ai requisiti dell'art. 17
2. ☐ **Esaminare la documentazione tecnica** per valutare la conformità ai requisiti del Capo III sezione 2 (artt. 8-15)
3. ☐ **Verificare che il processo** di progettazione e sviluppo e il monitoraggio post-immissione (art. 72) **siano coerenti con la documentazione tecnica** — cioè che ciò che è descritto corrisponda a ciò che è stato fatto

Esito positivo → dichiarazione di conformità UE (Allegato V) → marcatura CE (art. 48) → registrazione (art. 49). Nessun certificato: non c'è organismo notificato.

---

## ALLEGATO VII — Con organismo notificato

**Due domande distinte** allo stesso o a diversi organismi notificati: una per il **sistema di gestione della qualità**, una per la **documentazione tecnica del singolo sistema**. In entrambe è richiesta una dichiarazione scritta che **la stessa domanda non è stata presentata a nessun altro organismo notificato**.

**Sistema di gestione della qualità (punto 3):** un solo SGQ può coprire **più sistemi**, ma la documentazione tecnica va prodotta per ciascuno. Le modifiche al SGQ o all'elenco dei sistemi coperti vanno **notificate in anticipo** all'organismo notificato, che decide se serve una nuova valutazione.

**Documentazione tecnica (punto 4):**
- l'organismo notificato può ottenere **pieno accesso ai set di dati** di addestramento, convalida e prova, anche via API o accesso remoto → predisporre in anticipo il canale
- può chiedere elementi probatori supplementari, ulteriori prove, o effettuare prove proprie
- **accesso ai modelli** (compresi i parametri) solo come extrema ratio: necessità, esaurimento di ogni altro mezzo ragionevole, richiesta motivata, con salvaguardia di proprietà intellettuale e segreti commerciali
- esito positivo → **certificato di valutazione della documentazione tecnica dell'Unione**
- ⚠️ **conseguenza più pesante:** se la non conformità riguarda i **dati di addestramento** (art. 10), il sistema **deve essere riaddestrato** prima di una nuova domanda. Non è sanabile documentalmente.

**Modifiche al sistema (punto 4.7):** ogni modifica che possa incidere sulla conformità o sulla finalità prevista va **notificata preventivamente** all'organismo notificato che ha rilasciato il certificato, che decide fra nuova valutazione di conformità (art. 43 §4) e **supplemento** del certificato.

**Vigilanza (punto 5):** audit periodici, accesso ai locali di progettazione, sviluppo e prova, condivisione di tutte le informazioni necessarie. L'organismo notificato può effettuare prove supplementari sui sistemi certificati.

**Validità dei certificati (art. 44, non Allegato VII):**

| Tipo di sistema | Durata massima | Rinnovo |
|---|---|---|
| Alto rischio **Allegato I** | **5 anni** | proroghe di max 5 anni, su istanza e previa nuova valutazione |
| Alto rischio **Allegato III** | **4 anni** | proroghe di max 4 anni, su istanza e previa nuova valutazione |

I supplementi restano validi finché è valido il certificato principale. La proroga non è automatica.

---

## ALLEGATO VIII — Registrazione nella banca dati UE

### Sezione A — fornitori di sistemi ad alto rischio (art. 49 §1)
Nome, indirizzo e contatti del fornitore · dati di chi trasmette per suo conto · rappresentante autorizzato · denominazione commerciale e riferimento identificativo · **finalità prevista**, componenti e funzioni supportate · descrizione concisa dei dati di input e della logica operativa · **status** (sul mercato, in servizio, ritirato, richiamato) · tipo, numero e scadenza del certificato dell'organismo notificato e copia scannerizzata · Stati membri in cui è immesso · copia della dichiarazione di conformità UE · **istruzioni per l'uso in formato elettronico** (non dovute per Allegato III punti 1, 6 e 7) · indirizzo internet per ulteriori informazioni (facoltativo).

### Sezione B — sistemi auto-valutati come NON ad alto rischio (art. 49 §2)
Fornitore · chi trasmette per suo conto · rappresentante autorizzato · denominazione commerciale e riferimento identificativo · **finalità prevista** · **la o le condizioni dell'art. 6 §3 sulla cui base il sistema non è ritenuto ad alto rischio** · status.

> **Digital Omnibus:** soppressi i punti 7 (sintesi dei motivi) e 9 (Stati membri). La registrazione **resta obbligatoria** ma con contenuto informativo ridotto. Resta comunque dovuta la **documentazione della valutazione di non-alto-rischio prima dell'immissione sul mercato** (art. 6 §4), esibibile su richiesta.

### Sezione C — deployer che sono autorità pubbliche (art. 49 §3)
Nome e contatti del deployer · persona che fornisce le informazioni · **indirizzo internet dell'inserimento del sistema in banca dati da parte del fornitore** · sintesi dei risultati della **FRIA** (art. 27) · sintesi della **DPIA** ove applicabile.

### Regime speciale
I sistemi dell'Allegato III **punti 1, 6 e 7** usati nei settori contrasto, migrazione, asilo e frontiere si registrano in una **sezione sicura non pubblica**. I sistemi del **punto 2** (infrastrutture critiche) si registrano **a livello nazionale**, non nella banca dati UE.

---

## ALLEGATO IX — Prove in condizioni reali (art. 60)

Numero di identificazione unico a livello dell'Unione · nome e contatti del fornitore o potenziale fornitore e dei deployer coinvolti · breve descrizione del sistema e finalità prevista · sintesi delle principali caratteristiche del **piano di prova** · informazioni su sospensione o cessazione.

Queste informazioni sono accessibili **solo alle autorità di vigilanza del mercato e alla Commissione**, salvo consenso del fornitore.

---

## ALLEGATO XIII — Criteri per il rischio sistemico GPAI (art. 51)

Numero di parametri · qualità o dimensione del set di dati (es. in token) · quantità di calcolo per l'addestramento (FLOP, o costo, tempo, consumo energetico stimati) · modalità di input e output e soglie di punta per ciascuna modalità · parametri di riferimento e valutazioni delle capacità, incluso il numero di compiti eseguibili senza addestramento aggiuntivo, la capacità di apprendere nuovi compiti, il **livello di autonomia e scalabilità** e gli strumenti a cui il modello ha accesso · **alto impatto sul mercato interno**, presunto quando il modello è a disposizione di almeno **10 000 utenti commerciali registrati** stabiliti nell'Unione · numero di utenti finali registrati.

---

## Sequenza operativa

```
ALLEGATO IV (fascicolo tecnico)
   ├─► ALLEGATO VI  — controllo interno: verifica SGQ → esame doc → coerenza processo
   └─► ALLEGATO VII — con organismo notificato: domanda SGQ + domanda doc → CERTIFICATO
                       → vigilanza continua (audit periodici) e gestione delle modifiche
                                  ▼
                    ALLEGATO V (dichiarazione di conformità UE, art. 47)
                                  ▼
                    Marcatura CE (art. 48) + registrazione banca dati UE (art. 49, All. VIII)
                                  ▼
                    Monitoraggio post-mercato (art. 72) → aggiorna All. IV punti 6 e 9
```

## Nota sulle norme armonizzate

Alla data di redazione **nessuna norma armonizzata CEN-CENELEC è ancora stata citata nella Gazzetta ufficiale dell'Unione europea**. Il mandato di normazione C(2023)3215 al CEN/CENELEC JTC 21, con termine originario al 30 aprile 2025 poi spostato al 31 agosto 2025, è in ritardo; i lavori sono attesi oltre il 2026.

**Conseguenza pratica:** la **presunzione di conformità dell'art. 40 non è oggi disponibile** per nessun requisito. Chi deve dimostrare la conformità deve documentare **soluzioni proprie** ai sensi dell'Allegato IV punto 7. La Commissione può adottare **specifiche comuni** ex art. 41 come strumento sostitutivo; alla data di redazione non ne risultano adottate.
