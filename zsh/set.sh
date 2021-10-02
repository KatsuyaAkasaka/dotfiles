#!/bin/bash

# Update Homebrew recipes
brew update-reset && brew update

# Install zsh
rm $HOME/.Brewfile
ln -s $HOME/dotfiles/zsh/Brewfile $HOME/.Brewfile
brew bundle --global

# install java
ln -sfn $(brew --prefix)/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

echo "change default shell \"zsh\"..."
zshPass=`dirname $(which brew)`/zsh
# /opt/homebrew/bin/zsh
# Make ZSH the default shell environment 
grep $zshPass -rl /etc/shells
ref=$?
if [ $ref -ne 0 ]; then
	echo "set up zsh to default"
	sudo chmod 777 /etc/shells
	sh -c "echo $zshPass >> /etc/shells"
	sudo chmod 755 /etc/shells
fi
chsh -s $zshPass


echo "remove current .zshrc"
if [ -e $HOME/.zshrc ]; then
	rm -rf $HOME/.zshrc
fi
ln -s $HOME/dotfiles/zsh/.zshrc $HOME/.zshrc

if ! which zplug > /dev/null 2>&1; then
  echo "download zplug"
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

echo "installing envs"
git clone https://github.com/syndbg/goenv.git ~/.goenv

git clone git://github.com/nodenv/nodenv.git ~/.nodenv
cd ~/.nodenv && src/configure && make -C src
mkdir -p "$(nodenv root)"/plugins
git clone https://github.com/nodenv/node-build.git "$(nodenv root)"/plugins/node-build
git clone https://github.com/nodenv/nodenv-update.git "$(nodenv root)"/plugins/nodenv-update

git clone https://github.com/pyenv/pyenv.git ~/.pyenv
cd ~/.pyenv && src/configure && make -C src

echo "done!"

echo "loading zshrc..."
sudo chmod 755 $HOME/.zshrc
source $HOME/.zshrc
echo "done!"

if [ ! -e $HOME/google-cloud-sdk ]]; then
	echo "installing gcloud..."
	curl https://sdk.cloud.google.com | bash
fi

echo "changing terminal theme..."
export ZPLUG_HOME=/usr/local/opt/zplug
PURE=$HOME/.zplug/repos/sindresorhus/pure
rm $PURE/pure.plugin.zsh

ln -s $HOME/dotfiles/zsh/pure.plugin.zsh $PURE/pure.plugin.zsh
echo "done!"

echo "vscode vim enable to repeating..."
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false         # For VS Code
defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false # For VS Code Insider
echo "done!"
