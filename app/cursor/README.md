# How to setup readme

## Step.1

install Cursor (https://www.cursor.com/).

After launching Cursor once, open the command palette and run
`Shell Command: Install 'cursor' command in PATH` so the `cursor` CLI
is available — extension install in `setup.sh` depends on it.

## Step.2

run this command

```
sh setup.sh
```

This does two things:

1. Symlinks `settings.json` and `keybindings.json` to
   `~/Library/Application Support/Cursor/User/`.
2. Installs every extension listed in `extensions.txt` via
   `cursor --install-extension`.

## Step.3

🎉🎉🎉

## Updating the extension list

After you install or remove extensions in Cursor, refresh the dotfiles
list so the change is committed:

```
sh export-extensions.sh
```

Then commit the updated `extensions.txt`.

## Caution!!

if you change Cursor settings/keybindings, edit the files under
`app/cursor/` in dotfiles
(the symlinked files in `~/Library/Application Support/Cursor/User/`
point back here).
