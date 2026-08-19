# Quando una modifica ti rende fornitore

È la domanda più frequente per un integratore, e quella che sbaglia più spesso il verso. Quattro percorsi distinti, con soglie diverse.

## Percorso 1 — Integrazione di un modello di terzi (il caso normale)

Costruire un sistema su un modello altrui via API, con prompt personalizzati, RAG, orchestrazione di agenti, tool use.

- **Non ti rende fornitore del modello GPAI.** Il fornitore del modello resta chi lo ha immesso sul mercato.
- **Ti rende fornitore del *sistema*** se lo immetti sul mercato o lo metti in servizio **con il tuo nome o marchio** (art. 3 n. 3).
- **La classificazione di rischio si misura sul sistema finale che consegni, non sul modello a monte.** Un modello generalista dentro un sistema di screening delle candidature dà un sistema ad alto rischio; lo stesso modello dentro un assistente documentale no.
- Sei **fornitore a valle** ai sensi dell'art. 3 n. 68 e hai diritto, ex art. 53 §1 lett. b), a ricevere dal fornitore del modello le informazioni necessarie per adempiere ai tuoi obblighi.

## Percorso 2 — Rebranding (art. 25 §1 lett. a)

Apporre il proprio nome o marchio su un sistema **ad alto rischio** già immesso sul mercato.

- Trasferisce integralmente la qualifica di fornitore, **fatti salvi accordi contrattuali che prevedano una diversa ripartizione degli obblighi**.
- È il percorso più insidioso sul piano commerciale, perché il rebranding è esattamente ciò che molti integratori e rivenditori fanno per posizionamento di mercato.
- **Azione:** se rivendi o fai rivendere un prodotto con un marchio diverso, la ripartizione va scritta nell'accordo di rivendita.

## Percorso 3 — Cambio della finalità prevista (art. 25 §1 lett. c)

Destinare a un uso dell'Allegato III un sistema — anche per finalità generali — che non era classificato ad alto rischio.

- **Chi compie la scelta diventa fornitore.** Se è il cliente a ripuntare il sistema, è il cliente; se sei tu a configurarlo per quell'uso, anche su richiesta del cliente, sei tu.
- Il fornitore iniziale esce dal ruolo ma resta tenuto a cooperare e fornire accesso tecnico (art. 25 §2) — **salvo che abbia espressamente escluso la conversione ad alto rischio**, ipotesi in cui non è obbligato nemmeno alla consegna della documentazione.
- **Azione:** clausola di uso accettabile che escluda espressamente gli usi dell'Allegato III. È la protezione contrattuale più efficace disponibile.

## Percorso 4 — Modifica sostanziale (art. 25 §1 lett. b)

**Definizione, art. 3 n. 23:** modifica successiva all'immissione sul mercato **non prevista o programmata nella valutazione di conformità iniziale**, che incide sulla conformità ai requisiti del Capo III sezione 2 o comporta una modifica della finalità prevista.

- **Test pratico:** se la modifica rientra nel perimetro già valutato dal fornitore originario — parametri configurabili previsti, usi documentati nelle istruzioni — **non** è sostanziale.
- **Art. 43 §4:** per i sistemi che continuano ad apprendere dopo l'immissione sul mercato, le modifiche **predeterminate dal fornitore e documentate nella documentazione tecnica iniziale** non costituiscono modifica sostanziale.

---

# La soglia che dice quando diventi fornitore di un modello GPAI

Fonte: **Linee guida della Commissione sui modelli per finalità generali, 18 luglio 2025**. Sono soft law, non testo normativo, ma sono il criterio che l'Ufficio per l'IA dichiara di applicare.

> Chi modifica un modello GPAI di terzi **si presume diventato fornitore del modello** se la modifica impiega **almeno un terzo delle risorse computazionali** originariamente necessarie per addestrare il modello.

| Situazione | Soglia | Effetto |
|---|---|---|
| Qualifica come modello GPAI | training compute **> 10²³ FLOP** + criterio di generalità | il modello è GPAI |
| Modifica di un modello GPAI ordinario | **≥ 1/3 di 10²³ FLOP** (≈ 3,3 × 10²²) | presunzione di essere diventato fornitore GPAI |
| Modello con rischio sistemico | **≥ 10²⁵ FLOP** cumulativi | presunzione di capacità di impatto elevato; notifica alla Commissione entro **due settimane** |
| Modifica di un modello con rischio sistemico | **≥ 1/3 di 10²⁵ FLOP** (≈ 3,3 × 10²⁴) | fornitore + tutti gli obblighi dell'art. 55 |
| Precisione richiesta nella stima del compute | **± 30%**, con documentazione di assunzioni e incertezze | requisito delle linee guida |

**Se superi la soglia, gli obblighi sono limitati al perimetro della modifica**: documentazione tecnica, sintesi dei contenuti di addestramento e policy sul copyright riguardano **solo il compute e i dati aggiunti**, non il modello originario.

L'Ufficio per l'IA dichiara che la soglia è **indicativa** e che si aspetta che **pochissimi modificatori** diventino fornitori GPAI: le soglie sono state fissate deliberatamente alte.

## Come si collocano le tecniche più comuni

| Tecnica | Fornitore di modello GPAI? | Modifica sostanziale ex art. 3 n. 23? |
|---|---|---|
| Nessuna modifica, sola chiamata API | No | No |
| Prompt engineering, system prompt, custom GPT | No | No |
| **RAG su dati propri o del cliente** | **No** | No |
| Regolazione degli iperparametri di inferenza | No | No |
| Orchestrazione multi-agente, tool use | No | No — ma attenzione al cambio di finalità |
| **Fine-tuning ordinario** (LoRA, SFT su qualche migliaio di esempi) | **No** — ordini di grandezza sotto 1/3 del compute | Possibile, se incide sulla conformità o sulla finalità |
| Fine-tuning massivo, continued pre-training | Sì se ≥ 1/3 del compute originario | Sì |
| Distillazione, modifiche all'architettura core | Probabile | Sì |

> Una classificazione accademica diffusa (Hacker & Holweg, 2025) etichetta il fine-tuning come "modifica sostanziale". Va letta nel contesto giusto: rileva per l'**art. 25 §1 lett. b)** su un sistema ad alto rischio già in commercio, **non** per lo status di fornitore GPAI, dove conta solo la soglia di compute.

## Conclusione operativa per un integratore

Nella grande maggioranza dei casi — RAG, prompt engineering, agenti su API commerciali, custom GPT — **non si diventa fornitore di modello GPAI e spesso nemmeno fornitore di un sistema ad alto rischio**. Il rischio reale si concentra su tre punti, in ordine di probabilità:

1. **Rebranding** — vendere la soluzione con il proprio marchio come prodotto proprio.
2. **Cambio di finalità** che porta il sistema in Allegato III.
3. Fine-tuning massivo, raro nella pratica di uno studio o di una software house.

## Contratti a monte — art. 25 §4

Fornitori di sistemi ad alto rischio e terzi che forniscono strumenti, servizi, componenti o processi integrati devono stipulare **accordi scritti** che precisino informazioni, capacità, accesso tecnico e assistenza necessari. Esclusi i componenti con licenza libera e open source (esclusi i modelli GPAI). L'Ufficio per l'IA può elaborare clausole contrattuali tipo volontarie.

Le criticità ricorrenti segnalate nella prassi sono due, e sono entrambe contrattuali prima che tecniche: **mancanza di trasparenza del fornitore a monte** e **ambiguità sulle responsabilità** per insufficiente comunicazione tra le parti.
