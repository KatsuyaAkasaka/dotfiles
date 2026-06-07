# How to setup readme

## Step.1

run this command

```
sh setup.sh
```

This symlinks `.gitconfig` to `~/.gitconfig`.

## Step.2

🎉🎉🎉

## Caution!!

if you change git config, edit `app/git/.gitconfig` in dotfiles
(the symlinked `~/.gitconfig` points back here).

Do NOT use a private email in `[user] email` — GitHub blocks pushes that
would expose it. Use the noreply address
(`<id>+<login>@users.noreply.github.com`).
