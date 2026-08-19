#!/usr/bin/env bash
# Test di regressione del rilevamento firme di /ai-act scan.
#
# Cosa verifica (in modo deterministico, senza LLM):
#   - le firme `strong` rilevano ESATTAMENTE i file attesi in ogni fixture;
#   - la fixture senza IA (solo parole `weak`) NON produce alcun hit strong
#     → la "regola di promozione" di SCAN-2 regge (weak senza strong = niente componente).
#
# Cosa NON verifica: la classificazione legale (prosa generata dall'LLM). Quella è
# coperta dai campi `expected_risk_class` in expected.json, da usare come oracolo
# quando si valida a mano un run reale di `/ai-act scan` su una fixture.
#
# Il pattern `strong` qui sotto rispecchia la tabella `strong` di commands/ai-act.md
# (SCAN-2). Se cambi le firme là, aggiorna qui — il test lo ricorderà fallendo.
#
# Uso:  ./tests/run-signatures.sh        # esce 0 se tutto verde, 1 al primo mismatch

set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
FIX="$ROOT/tests/fixtures"

# Firme STRONG (case-insensitive), speculari a SCAN-2.
# Nota: usa `grep -E` portabile (POSIX) — niente dipendenza da `rg`, che spesso
# non è nel PATH di un subprocess bash. Evita `\b` (non portabile in BSD grep).
STRONG='anthropic|@anthropic-ai|claude-|openai|gpt-4|gpt-5|mistral|cohere|gemini|genai|ollama|bedrock|azure.*openai|langchain|llama[-_]?index|semantic-kernel|haystack|crewai|autogen|pgvector|pinecone|qdrant|weaviate|chroma|faiss|fastembed|vector_store|VectorStoreIndex|sklearn|scikit|xgboost|lightgbm|tensorflow|torch|onnx|mediapipe|opencv|deepface|insightface|whisper|elevenlabs|voice_clone|stable-diffusion|dall-e|midjourney|deepfake'

fail=0
pass=0

command -v jq >/dev/null || { echo "jq richiesto"; exit 2; }

for dir in "$FIX"/*/; do
  name="$(basename "$dir")"
  exp="$dir/expected.json"
  [[ -f "$exp" ]] || { echo "SKIP $name (manca expected.json)"; continue; }

  # File di codice con almeno un hit strong (basename, unici, ordinati).
  got="$(grep -rEil --exclude='expected.json' -e "$STRONG" "$dir" 2>/dev/null \
          | xargs -n1 basename 2>/dev/null | sort -u | tr '\n' ' ' | sed 's/ *$//')"
  want="$(jq -r '.strong_hit_files | sort | join(" ")' "$exp")"

  if [[ "$got" == "$want" ]]; then
    echo "PASS  $name  → strong: [${got:-<nessuno>}]"
    pass=$((pass+1))
  else
    echo "FAIL  $name"
    echo "      atteso : [$want]"
    echo "      trovato: [${got:-<nessuno>}]"
    fail=$((fail+1))
  fi
done

echo ""
echo "Risultato: $pass passati, $fail falliti."
[[ $fail -eq 0 ]] || exit 1
