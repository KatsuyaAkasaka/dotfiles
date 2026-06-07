#! /bin/zsh

CURSOR_USER_DIR="$HOME/Library/Application Support/Cursor/User"

mkdir -p "$CURSOR_USER_DIR"

rm -f "$CURSOR_USER_DIR/settings.json"
ln -s "$HOME/dotfiles/app/cursor/settings.json" "$CURSOR_USER_DIR/settings.json"

rm -f "$CURSOR_USER_DIR/keybindings.json"
ln -s "$HOME/dotfiles/app/cursor/keybindings.json" "$CURSOR_USER_DIR/keybindings.json"

# install extensions listed in extensions.txt (skip blanks and comments)
if command -v cursor >/dev/null 2>&1; then
  while IFS= read -r ext; do
    case "$ext" in
      ''|\#*) continue ;;
    esac
    cursor --install-extension "$ext" --force
  done < "$HOME/dotfiles/app/cursor/extensions.txt"
else
  echo "cursor CLI not found in PATH — skipping extension install."
  echo "Open Cursor and run 'Shell Command: Install cursor command in PATH'."
fi
