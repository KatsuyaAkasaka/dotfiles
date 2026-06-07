# How to setup readme

## Step.1

install `mise` (already installed through `zsh/Brewfile`)

## Step.2

run this command

```
sh setup.sh
```

This symlinks `config.toml` to `~/.config/mise/config.toml` and runs `mise install`.

## Step.3

🎉🎉🎉

## Caution!!

if you change tools/config, edit `app/mise/config.toml` in dotfiles
(the symlinked `~/.config/mise/config.toml` points back here).
