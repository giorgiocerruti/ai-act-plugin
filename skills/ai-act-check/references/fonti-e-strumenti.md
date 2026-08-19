# Fonti, strumenti e loro affidabilità

Regola generale: **per il contenuto degli obblighi vanno bene più fonti; per le date vale solo EUR-Lex.** Il Digital Omnibus ha spostato quasi tutte le scadenze e la maggior parte delle fonti in circolazione riporta ancora il calendario del 2024.

## Fonti primarie

| Fonte | URL | Affidabilità | Aggiornata al Reg. 2026/1744 |
|---|---|---|---|
| **EUR-Lex — testo consolidato** | `https://eur-lex.europa.eu/eli/reg/2024/1689/ita` (ultima versione) · `.../2024/1689/2026-07-27/ita` (versione post-Omnibus) | **Fonte ufficiale. Fa fede.** | **Sì** |
| Digital Omnibus, atto modificativo | `https://eur-lex.europa.eu/legal-content/IT/TXT/HTML/?uri=OJ:L_202601744` | Ufficiale | — è l'atto stesso |
| AI Act originario in GUUE | `https://eur-lex.europa.eu/legal-content/IT/TXT/PDF/?uri=OJ:L_202401689` | Ufficiale | No, è il testo originario |
| **AI Act Service Desk** (Commissione) | `https://ai-act-service-desk.ec.europa.eu/it/ai-act/article-NN` | Portale ufficiale della Commissione. Traduzioni italiane con **disclaimer di traduzione automatica** | **No** — l'art. 113 mostra ancora le date del 2024 |
| Commissione — quadro normativo IA | `https://digital-strategy.ec.europa.eu/it/policies/regulatory-framework-ai` | Ufficiale, ospita orientamenti e codici | Parzialmente |

**Come usarli insieme:** Service Desk per leggere il testo di un articolo in italiano, EUR-Lex consolidato per verificare che quel testo sia ancora quello vigente e per ogni data.

## Soft law rilevante

- **Orientamenti della Commissione sugli obblighi di trasparenza (art. 50)** — 22 luglio 2026, con **codice di buone pratiche volontario sulla marcatura** e set di **icone standardizzate**. È la fonte che risolve le questioni di ambito dell'art. 50.
- **Linee guida sui modelli GPAI** — 18 luglio 2025. Contengono la soglia di **1/3 del compute** per il modificatore (vedi `modifiche-e-ruolo.md`) e le soglie 10²³ / 10²⁵ FLOP.
- **Codice di buone pratiche GPAI** — luglio 2025: capitoli su trasparenza, diritto d'autore, sicurezza.
- **Template della Commissione per la sintesi pubblica dei dati di addestramento** — art. 53 §1 lett. d).
- **Living repository sulle prassi di alfabetizzazione IA** e **FAQ sull'AI literacy** — `digital-strategy.ec.europa.eu`. Sono la risposta concreta alla domanda "che cosa basta per l'art. 4".
- **Orientamenti sulla classificazione alto rischio (art. 6 §5)** — attesi, con elenco esaustivo di esempi pratici di casi ad alto rischio e non.

## Fonti non ufficiali utili, con avvertenza

**artificialintelligenceact.eu** — progetto indipendente del Future of Life Institute. Ottimo per: struttura del regolamento, allegati, considerando, guide tematiche (PMI, HR, art. 50, modifiche ai modelli), panoramica su sandbox e piani nazionali. **Riporta il testo del 13 giugno 2024 e la timeline è ferma al 1° agosto 2024: non usarlo per le date.** Il suo *Compliance Checker* (`/assessment/eu-ai-act-compliance-checker/`) è un albero decisionale utile come **pre-screening** e come documentazione del ragionamento verso il cliente, ma il changelog si ferma a luglio 2025.

## Stato della normazione tecnica

Mandato **C(2023)3215** del 22 maggio 2023 a CEN e CENELEC (comitato **JTC 21**). Termine originario 30 aprile 2025, poi 31 agosto 2025, entrambi mancati; i lavori proseguono oltre il 2026.

**Nessuna norma armonizzata è ancora citata in GUUE** → la **presunzione di conformità dell'art. 40 non è disponibile**. Chi deve dimostrare la conformità documenta soluzioni proprie ai sensi dell'Allegato IV punto 7. La Commissione può adottare **specifiche comuni** ex art. 41; alla data di redazione non ne risultano adottate.

Dashboard CEN-CENELEC: `standards.cencenelec.eu` (può non riflettere i piani più recenti).

## Italia

- **L. 23 settembre 2025, n. 132** — prima legge nazionale di attuazione in Europa, in vigore dal 10 ottobre 2025.
- **ACN** — autorità di vigilanza del mercato e punto di contatto unico. **AgID** — autorità di notifica. Cinque autorità designate per i diritti fondamentali (art. 77). Banca d'Italia, CONSOB, IVASS per i settori vigilati (art. 74 §6); Garante privacy per l'Allegato III punti 1, 6, 7 e 8 nei settori contrasto, frontiere, giustizia (art. 74 §8).
- **Decreti attuativi**: schema AG 421 (governance, vigilanza, sanzioni, sandbox) e schema penale (nuovo art. 437-bis c.p., responsabilità 231). **Non ancora pubblicati in Gazzetta Ufficiale**; delega in scadenza il 10 ottobre 2026.
- **Sandbox nazionale**: non ancora istituita. Termine, dopo il Digital Omnibus, **2 agosto 2027**.
- **Art. 612-quater c.p.** — illecita diffusione di contenuti generati o alterati con IA: reclusione da 1 a 5 anni, procedibile a querela. Già in vigore.

## Normative adiacenti da non dimenticare

Nella pratica il rischio concreto è spesso qui, non nell'AI Act.

| Ambito | Norma | Quando rileva |
|---|---|---|
| Protezione dati | GDPR, in particolare artt. 13-14, 22, 35 | Sempre, quando ci sono dati personali. La DPIA è dovuta indipendentemente dalla classe di rischio AI Act |
| **Lavoro — controllo a distanza** | **art. 4 L. 300/1970** | Qualsiasi strumento da cui derivi la possibilità di controllo dell'attività dei lavoratori: serve accordo sindacale o autorizzazione dell'Ispettorato. **Vale anche senza AI** |
| **Lavoro — decisioni automatizzate** | **art. 1-bis D.Lgs. 152/1997, introdotto dal D.Lgs. 104/2022** ("decreto trasparenza") | Uso di sistemi decisionali o di monitoraggio automatizzati per assunzione, gestione o cessazione del rapporto: obbligo di informativa dettagliata a lavoratori e rappresentanti sindacali. **Già in vigore, cumulativo con l'AI Act** |
| Whistleblowing | Direttiva 2019/1937, in Italia **D.Lgs. 24/2023** | Imprese con 50+ dipendenti: canale interno obbligatorio. L'art. 87 AI Act **estende l'oggetto** delle segnalazioni protette alle violazioni del regolamento — azione minima: aggiornare la policy interna |
| Pubblicità e pratiche commerciali | **D.Lgs. 145/2007** (B2B, competenza AGCM) · artt. 20-23 Cod. cons. (verso consumatori e microimprese) | Claim su capacità "AI" non corrispondenti al vero |
| Dispositivi medici | Reg. 2017/745 (MDR), Reg. 2017/746 (IVDR) | Software con finalità diagnostica o terapeutica |
| Piattaforme | Reg. 2022/2065 (DSA) | Sistemi di raccomandazione, VLOP/VLOSE |
| Responsabilità | Direttiva 2024/2853 sulla responsabilità per danno da prodotti difettosi | Include il software fra i prodotti |

## Misure di favore per le PMI

Accesso **gratuito e prioritario** alle sandbox, con **protezione dalle sanzioni amministrative** se si segue in buona fede il piano concordato · documentazione tecnica **semplificata** con modulo della Commissione, che gli organismi notificati devono accettare · sistema di gestione della qualità **proporzionato alle dimensioni** · tariffe di valutazione della conformità proporzionali · **tetto sanzionatorio al minore** fra importo fisso e percentuale · canali nazionali di supporto dedicati · KPI separati nel codice GPAI. Il Digital Omnibus ha esteso parte di queste misure alle **piccole imprese a media capitalizzazione**.

Canale di accesso più praticabile oggi in Italia, in assenza di sandbox nazionale: gli **EDIH** (European Digital Innovation Hubs) e le **TEF** (Testing and Experimentation Facilities).
