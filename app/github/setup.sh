#! /bin/zsh

ssh-keygen -t rsa -f ~/.ssh/id_rsa_github

ln -s ./ssh_config ~/.ssh/config

git config --global user.name "Katsuya Akasaka"
git config --global user.email "akasakatora1208@gmail.om"
