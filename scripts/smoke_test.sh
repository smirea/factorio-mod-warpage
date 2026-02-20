#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

FACTORIO_BIN="${FACTORIO_BIN:-/Users/stefan/Library/Application Support/Steam/steamapps/common/Factorio/factorio.app/Contents/MacOS/factorio}"
MODS_ROOT="${MODS_ROOT:-$HOME/code/factorio-mods}"
MOD_LINK="$MODS_ROOT/warpage_0.1.0"
UNTIL_TICK="${UNTIL_TICK:-60}"

SMOKE_ROOT="${SMOKE_ROOT:-$REPO_ROOT/.tmp/factorio-smoke}"
RUN_MOD_DIR="$SMOKE_ROOT/mods"
WRITE_DATA="$SMOKE_ROOT/write-data"
CONFIG_FILE="$SMOKE_ROOT/config.ini"
SAVE_FILE="$SMOKE_ROOT/warpage-smoke.zip"
CREATE_OUT="$SMOKE_ROOT/create.out"
LOAD_OUT="$SMOKE_ROOT/load.out"
LOG_FILE="$WRITE_DATA/factorio-current.log"

if [ ! -x "$FACTORIO_BIN" ]; then
  echo "Factorio binary not found or not executable: $FACTORIO_BIN" >&2
  exit 1
fi

if [ ! -d "$MODS_ROOT" ]; then
  echo "Mods directory does not exist: $MODS_ROOT" >&2
  exit 1
fi

if [ -e "$MOD_LINK" ]; then
  if [ ! -L "$MOD_LINK" ]; then
    echo "$MOD_LINK exists but is not a symlink." >&2
    exit 1
  fi

  current_target="$(readlink "$MOD_LINK")"
  if [ "$current_target" != "$REPO_ROOT" ]; then
    echo "$MOD_LINK points to $current_target, expected $REPO_ROOT" >&2
    exit 1
  fi
else
  ln -s "$REPO_ROOT" "$MOD_LINK"
fi

if [ -d "$SMOKE_ROOT" ]; then
  trash "$SMOKE_ROOT"
fi

mkdir -p "$RUN_MOD_DIR" "$WRITE_DATA"
ln -s "$MOD_LINK" "$RUN_MOD_DIR/warpage_0.1.0"

cat > "$CONFIG_FILE" <<CFG
[path]
read-data=__PATH__system-read-data__
write-data=$WRITE_DATA
CFG

cat > "$RUN_MOD_DIR/mod-list.json" <<'MODLIST'
{
  "mods": [
    { "name": "base", "enabled": true },
    { "name": "warpage", "enabled": true }
  ]
}
MODLIST

"$FACTORIO_BIN" \
  --config "$CONFIG_FILE" \
  --mod-directory "$RUN_MOD_DIR" \
  --disable-audio \
  --verbose \
  --create "$SAVE_FILE" > "$CREATE_OUT" 2>&1

"$FACTORIO_BIN" \
  --config "$CONFIG_FILE" \
  --mod-directory "$RUN_MOD_DIR" \
  --disable-audio \
  --verbose \
  --load-game "$SAVE_FILE" \
  --until-tick "$UNTIL_TICK" > "$LOAD_OUT" 2>&1

if rg -n -i "(failed to load mods|lua stack traceback|critical|error while)" "$CREATE_OUT" "$LOAD_OUT" "$LOG_FILE"; then
  echo "Smoke test failed; see logs under $SMOKE_ROOT" >&2
  exit 1
fi

echo "Smoke test passed."
echo "create log: $CREATE_OUT"
echo "load log:   $LOAD_OUT"
echo "factorio log: $LOG_FILE"
