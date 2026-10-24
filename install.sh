#!/usr/bin/env bash
# Symlinks this repo into ~/.config and installs deps. Safe to re-run.
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG="$HOME/.config"
mkdir -p "$CONFIG"

link() { # link <repo-relative src> <dest>
  local src="$REPO/$1" dest="$2"
  if [[ "$src" == "$dest" || ( -L "$dest" && "$(readlink "$dest")" == "$src" ) ]]; then
    echo "ok      $dest"; return
  fi
  if [[ -e "$dest" || -L "$dest" ]]; then
    mv "$dest" "$dest.bak.$(date +%s)"
    echo "backup  $dest"
  fi
  mkdir -p "$(dirname "$dest")"
  ln -s "$src" "$dest"
  echo "link    $dest -> $src"
}

# Homebrew
if ! command -v brew >/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"
brew bundle --file="$REPO/Brewfile"

# ~/.config links
for d in nvim wezterm zsh git opencode claude; do link "$d" "$CONFIG/$d"; done
link aerospace/aerospace.toml "$CONFIG/aerospace/aerospace.toml"
link starship.toml            "$CONFIG/starship.toml"
link cheat.md                 "$CONFIG/cheat.md"

# zsh reads its config from ~/.config/zsh
if ! grep -qs ZDOTDIR "$HOME/.zshenv"; then
  echo 'export ZDOTDIR="$HOME/.config/zsh"' >> "$HOME/.zshenv"
  echo "wrote   ~/.zshenv"
fi

# Claude Code: my config lives here, machine state (sessions, memory, auth) stays in ~/.claude
link claude/settings.json "$HOME/.claude/settings.json"
link claude/CLAUDE.md     "$HOME/.claude/CLAUDE.md"
link claude/agents        "$HOME/.claude/agents"
for s in "$REPO"/claude/skills/*/; do
  s="$(basename "$s")"
  link "claude/skills/$s" "$HOME/.claude/skills/$s"
done
(cd "$REPO/claude/skills/brand-exploration/scripts" && npm install --silent)

# skills from the separate ~/Projects/skills repo
for s in monorepo-structure reddit youtube-research; do
  if [[ -d "$HOME/Projects/skills/skills/$s" ]]; then
    ln -sfn "$HOME/Projects/skills/skills/$s" "$HOME/.claude/skills/$s"
  fi
done

# secrets (gitignored)
[[ -f "$REPO/zsh/secrets.sh" ]] || cp "$REPO/zsh/secrets.template.sh" "$REPO/zsh/secrets.sh"

# Fonts
cp -n "$REPO"/fonts/jetbrains-mono/JetBrainsMonoNerdFontMono-*.ttf "$REPO"/fonts/cascadia-code/*.ttf "$HOME/Library/Fonts/" 2>/dev/null || true

echo "Done. Open a new terminal. Fill in ~/.config/zsh/secrets.sh, then launch nvim once to bootstrap plugins."
