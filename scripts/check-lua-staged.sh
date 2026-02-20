#!/usr/bin/env bash

set -euo pipefail

repo_root="$(git rev-parse --show-toplevel)"
cd "$repo_root"

resolve_lua_ls_bin() {
  if command -v lua-language-server >/dev/null 2>&1; then
    command -v lua-language-server
    return 0
  fi

  if [[ -n "${LUA_LANGUAGE_SERVER_BIN:-}" && -x "${LUA_LANGUAGE_SERVER_BIN}" ]]; then
    printf '%s\n' "${LUA_LANGUAGE_SERVER_BIN}"
    return 0
  fi

  local candidates=(
    "$HOME/.local/share/nvim/mason/packages/lua-language-server/lua-language-server"
    "$HOME/.local/share/nvim/mason/packages/lua-language-server/libexec/bin/lua-language-server"
  )
  local candidate
  for candidate in "${candidates[@]}"; do
    if [[ -x "$candidate" ]]; then
      printf '%s\n' "$candidate"
      return 0
    fi
  done

  shopt -s nullglob
  for candidate in "$HOME"/.cursor/extensions/sumneko.lua-*/server/bin/lua-language-server; do
    if [[ -x "$candidate" ]]; then
      printf '%s\n' "$candidate"
      shopt -u nullglob
      return 0
    fi
  done
  shopt -u nullglob

  return 1
}

lua_ls_bin="$(resolve_lua_ls_bin || true)"
if [[ -z "$lua_ls_bin" ]]; then
  echo "LuaLS check failed: lua-language-server not found."
  echo "Install lua-language-server or set LUA_LANGUAGE_SERVER_BIN."
  exit 1
fi

if [[ ! -f "$repo_root/.luarc.json" ]]; then
  echo "LuaLS check failed: missing $repo_root/.luarc.json"
  exit 1
fi

files=()
for input_file in "$@"; do
  case "$input_file" in
    *.lua) ;;
    *) continue ;;
  esac

  if [[ -f "$input_file" ]]; then
    files+=("$input_file")
  elif [[ -f "$repo_root/$input_file" ]]; then
    files+=("$repo_root/$input_file")
  fi
done

if [[ ${#files[@]} -eq 0 ]]; then
  echo "LuaLS: no staged Lua files to check."
  exit 0
fi

echo "LuaLS: checking ${#files[@]} staged Lua file(s)..."
for file_path in "${files[@]}"; do
  "$lua_ls_bin" \
    --configpath "$repo_root/.luarc.json" \
    --check "$file_path" \
    --checklevel=Warning
done

