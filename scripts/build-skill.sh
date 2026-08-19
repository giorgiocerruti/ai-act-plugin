#!/usr/bin/env bash
# Impacchetta la skill `ai-act-check` come Agent Skill standalone, caricabile su
# Claude (app claude.ai / desktop) o usabile via API / Agent SDK.
#
# La sorgente resta una sola: skills/ai-act-check/. Questo script non duplica
# nulla, produce solo l'archivio distribuibile in dist/.
#
# Uso:  ./scripts/build-skill.sh
# Output: dist/ai-act-check.zip  (SKILL.md alla radice della cartella + references/)

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILL_DIR="$ROOT/skills/ai-act-check"
OUT_DIR="$ROOT/dist"
OUT_ZIP="$OUT_DIR/ai-act-check.zip"

if [[ ! -f "$SKILL_DIR/SKILL.md" ]]; then
  echo "Errore: $SKILL_DIR/SKILL.md non trovato." >&2
  exit 1
fi

# Verifica minima del frontmatter Agent Skill: name + description presenti,
# description entro il limite di 1024 caratteri.
desc="$(sed -n 's/^description: //p' "$SKILL_DIR/SKILL.md" | head -1)"
if [[ -z "$desc" ]]; then
  echo "Errore: campo 'description' mancante nel frontmatter di SKILL.md." >&2
  exit 1
fi
len="$(printf '%s' "$desc" | wc -c | tr -d ' ')"
if (( len > 1024 )); then
  echo "Errore: description di $len caratteri, oltre il limite Agent Skill di 1024." >&2
  exit 1
fi

mkdir -p "$OUT_DIR"
rm -f "$OUT_ZIP"

# Zippa la cartella della skill (si estrae in ai-act-check/SKILL.md + references/).
# Esclude i file di sistema.
( cd "$ROOT/skills" && zip -rq "$OUT_ZIP" ai-act-check -x '*.DS_Store' '*/.*' )

echo "Creato: $OUT_ZIP"
echo "description: $len/1024 caratteri · references: $(ls "$SKILL_DIR/references" | wc -l | tr -d ' ') file"
echo "Carica lo zip su Claude come Agent Skill, oppure caricalo via API / Agent SDK."
