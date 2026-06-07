#! /bin/zsh

mkdir -p ~/.config/mise
rm -f $HOME/.config/mise/config.toml
ln -s $HOME/dotfiles/app/mise/config.toml $HOME/.config/mise/config.toml

# install all tools defined in config.toml
mise install
