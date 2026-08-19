# Test di regressione

Il valore del plugin sta nel rilevare i componenti IA giusti e non inventarne. Questi test lo verificano nella parte **deterministica** (il rilevamento delle firme), quella che si può controllare senza far girare un LLM.

## Cosa c'è

```
tests/
  run-signatures.sh     harness: firme strong → file attesi, per ogni fixture
  fixtures/
    high-risk-cv-screener/   LLM + dominio lavoro → atteso: alto rischio (Allegato III §4)
    limited-chatbot/         LLM che parla con persone → atteso: rischio limitato (art. 50)
    no-ai-rest-api/          API senza IA, con parole weak-trappola → atteso: nessun componente
    */expected.json          oracolo: file strong attesi, classe attesa, note
```

## Come si esegue

```bash
./tests/run-signatures.sh
```

Esce `0` se in ogni fixture le firme `strong` rilevano **esattamente** i file attesi; `1` al primo scostamento. La fixture `no-ai-rest-api` è la più importante: contiene `score` e `credit` (firme `weak`) ma nessuna tecnologia IA `strong` — il test verifica che **non** produca componenti, cioè che la *regola di promozione* di SCAN-2 regga.

## Cosa NON testano

La classificazione legale è prosa generata dall'LLM: non la si asserisce meccanicamente. Il campo `expected_risk_class` in ogni `expected.json` è l'**oracolo** con cui confrontare a mano un run reale di `/ai-act scan` sulla fixture. Per aggiungere un caso: crea una cartella con un file sorgente minimo e un `expected.json`.

## Portabilità

L'harness usa `grep -E` POSIX (non `rg`, che spesso non è nel PATH di un subprocess) e `jq`. Se cambi le firme `strong` in `commands/ai-act.md`, aggiorna anche il pattern in `run-signatures.sh`: il test fallirà finché non lo fai — è il promemoria.
