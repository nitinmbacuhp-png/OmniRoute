#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

echo "== OmniRoute + OpenCode Android bootstrap =="

pkg update -y
pkg install -y git nodejs-lts curl

if ! command -v opencode >/dev/null 2>&1; then
  npm install -g opencode-ai
fi

mkdir -p "$HOME/.config/opencode"

cat > "$HOME/.config/opencode/opencode.json" <<'JSON'
{
  "$schema": "https://opencode.ai/config.json",
  "model": "omniroute/nvidia/nemotron-3-ultra-550b-a55b",
  "provider": {
    "omniroute": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "OmniRoute",
      "options": {
        "baseURL": "{env:OMNIROUTE_BASE_URL}",
        "apiKey": "{env:OMNIROUTE_API_KEY}"
      },
      "models": {
        "nvidia/nemotron-3-ultra-550b-a55b": {
          "name": "Nemotron 3 Ultra 550B A55B",
          "limit": {
            "context": 1000000,
            "output": 32768
          }
        }
      }
    }
  }
}
JSON

cat <<'EOF'
Bootstrap complete.

Set OMNIROUTE_BASE_URL and OMNIROUTE_API_KEY in your Termux environment when credentials are available.
No credentials are written to GitHub by this script.

Launch:
  opencode
EOF
