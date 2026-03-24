#!/bin/bash
# PreToolUse hook: Rewrite npm/npx commands to pnpm equivalents

command -v jq >/dev/null 2>&1 || exit 0

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // ""')
FIRST_TOKEN=$(echo "$COMMAND" | awk '{print $1}')

# Only intercept npm/npx
case "$FIRST_TOKEN" in
  npm|npx) ;;
  *) echo "$INPUT"; exit 0 ;;
esac

rewrite() {
  local cmd="$1"

  # npx → pnpm dlx (one-off) or pnpm exec (local bin)
  if [[ "$cmd" =~ ^npx[[:space:]]+-y[[:space:]]+(.+) ]]; then
    echo "pnpm dlx ${BASH_REMATCH[1]}"; return
  fi
  if [[ "$cmd" =~ ^npx[[:space:]]+(.+) ]]; then
    echo "pnpm exec ${BASH_REMATCH[1]}"; return
  fi

  local rest="${cmd#* }"
  local subcmd="${rest%% *}"
  local args="${rest#* }"
  [[ "$rest" == "$subcmd" ]] && args=""

  case "$subcmd" in
    install|i)  [[ -z "$args" ]] && echo "pnpm install" || echo "pnpm add $args" ;;
    ci)         echo "pnpm install --frozen-lockfile" ;;
    add)        echo "pnpm add $args" ;;
    remove|rm|uninstall|un) echo "pnpm remove $args" ;;
    run)        echo "pnpm run $args" ;;
    test|t)     echo "pnpm test $args" ;;
    exec)       echo "pnpm exec $args" ;;
    *)          echo "pnpm $rest" ;;
  esac
}

NEW_CMD=$(rewrite "$COMMAND")
echo "$INPUT" | jq --arg cmd "$NEW_CMD" '.tool_input.command = $cmd'
