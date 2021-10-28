#! /bin/zsh

mkdir -p ~/.config
rm -f $HOME/.config/karabiner/karabiner.json
ln -s $HOME/dotfiles/app/karabiner/karabiner.json $HOME/.config/karabiner/karabiner.json
