#! /bin/zsh

# Dump the currently installed Cursor extensions to extensions.txt.
# Run this after installing/removing extensions to sync the dotfiles list.

cursor --list-extensions > "$HOME/dotfiles/app/cursor/extensions.txt"
