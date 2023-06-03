#! /bin/zsh

mkdir $HOME/.ssh

ssh-keygen -t ed25519 -C "akasakatora1208@gmail.com" -f $HOME/.ssh/id_ed25519_github
cd $HOME/dotfiles

ln -s $HOME/dotfiles/app/github/ssh_config $HOME/.ssh/config

git config --global user.name "KatsuyaAkasaka"
git config --global user.email "akasakatora1208@gmail.com"
