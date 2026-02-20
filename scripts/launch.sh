#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

FACTORIO_BIN="${FACTORIO_BIN:-}"
MODS_ROOT="${MODS_ROOT:-$HOME/code/factorio-mods}"
MOD_LINK="$MODS_ROOT/warpage_0.1.0"

LAUNCH_ROOT="${LAUNCH_ROOT:-$REPO_ROOT/.tmp/factorio-launch}"
RUN_MOD_DIR="$LAUNCH_ROOT/mods"
RUN_MOD_LINK="$RUN_MOD_DIR/warpage_0.1.0"
WRITE_DATA="$LAUNCH_ROOT/write-data"
CONFIG_FILE="$LAUNCH_ROOT/config.ini"
DEFAULT_SAVE_NAME="${SAFE_SAVE_NAME:-warpage-test}"

HEADLESS="${HEADLESS:-0}"
UNTIL_TICK="${UNTIL_TICK:-120}"

if [ -z "$FACTORIO_BIN" ]; then
  candidates=(
    "/Applications/factorio.app/Contents/MacOS/factorio"
    "$HOME/Applications/factorio.app/Contents/MacOS/factorio"
    "$HOME/.factorio/bin/x64/factorio"
    "$HOME/Library/Application Support/factorio/bin/x64/factorio"
    "$HOME/Library/Application Support/Steam/steamapps/common/Factorio/factorio.app/Contents/MacOS/factorio"
  )

  for candidate in "${candidates[@]}"; do
    if [ -x "$candidate" ]; then
      FACTORIO_BIN="$candidate"
      break
    fi
  done
fi

save_selector="$DEFAULT_SAVE_NAME"
if [ "${1:-}" != "" ] && [[ "${1:-}" != --* ]]; then
  save_selector="$1"
  shift
fi

if [[ "$save_selector" == */* ]] || [[ "$save_selector" == *.zip ]]; then
  if [[ "$save_selector" = /* ]]; then
    save_file="$save_selector"
  else
    save_file="$REPO_ROOT/$save_selector"
  fi
else
  save_file="$WRITE_DATA/saves/$save_selector.zip"
fi

if [ -z "$FACTORIO_BIN" ] || [ ! -x "$FACTORIO_BIN" ]; then
  echo "Factorio binary not found." >&2
  echo "Set FACTORIO_BIN explicitly or install Factorio in a standard location." >&2
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

mkdir -p "$RUN_MOD_DIR" "$WRITE_DATA/saves"

if [ -e "$RUN_MOD_LINK" ]; then
  if [ ! -L "$RUN_MOD_LINK" ]; then
    echo "$RUN_MOD_LINK exists but is not a symlink." >&2
    exit 1
  fi

  run_target="$(readlink "$RUN_MOD_LINK")"
  if [ "$run_target" != "$MOD_LINK" ]; then
    trash "$RUN_MOD_LINK"
    ln -s "$MOD_LINK" "$RUN_MOD_LINK"
  fi
else
  ln -s "$MOD_LINK" "$RUN_MOD_LINK"
fi

cat > "$CONFIG_FILE" <<CFG
[path]
read-data=__PATH__system-read-data__
write-data=$WRITE_DATA
CFG

cat > "$RUN_MOD_DIR/mod-list.json" <<'MODLIST'
{
  "mods": [
    { "name": "base", "enabled": true },
    { "name": "elevated-rails", "enabled": true },
    { "name": "quality", "enabled": true },
    { "name": "space-age", "enabled": true },
    { "name": "warpage", "enabled": true }
  ]
}
MODLIST

if [ ! -f "$save_file" ]; then
  echo "Save not found. Creating: $save_file"
  "$FACTORIO_BIN" \
    --config "$CONFIG_FILE" \
    --mod-directory "$RUN_MOD_DIR" \
    --disable-audio \
    --verbose \
    --create "$save_file"
fi

cmd=(
  "$FACTORIO_BIN"
  --config "$CONFIG_FILE"
  --mod-directory "$RUN_MOD_DIR"
  --disable-audio
  --verbose
  --load-game "$save_file"
)

if [ "$HEADLESS" = "1" ]; then
  cmd+=(--until-tick "$UNTIL_TICK")
fi

if [ "$#" -gt 0 ]; then
  cmd+=("$@")
fi

echo "Launching Factorio"
echo "save: $save_file"
echo "write-data: $WRITE_DATA"
echo "headless: $HEADLESS"

exec "${cmd[@]}"
