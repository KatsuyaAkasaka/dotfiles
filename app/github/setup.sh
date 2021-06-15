#! /bin/zsh

cd ~/.ssh
ssh-keygen -t rsa
cd ~/dotfiles

ln -s ~/dotfiles/app/github/ssh_config ~/.ssh/config

git config --global user.name "KatsuyaAkasaka"
git config --global user.email "akasakatora1208@gmail.om"
