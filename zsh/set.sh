#!/bin/bash

echo "installing homebrew..."
# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew recipes
brew update

# Install zsh
rm $HOME/.Brewfile
ln -s $HOME/dotfiles/zsh/Brewfile $HOME/.Brewfile
brew bundle --global

echo "change default shell \"zsh\"..."
zshPass=`which zsh`
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


# remove current .zshrc
if [[ -e $HOME/.zshrc ]]; then
	rm -rf $HOME/.zshrc
fi
ln -s $HOME/dotfiles/zsh/.zshrc $HOME/.zshrc
# download zplug
echo "done!"

echo "installing envs"
git clone https://github.com/syndbg/goenv.git ~/.goenv

git clone git://github.com/nodenv/nodenv.git ~/.nodenv
cd ~/.nodenv && src/configure && make -C src
git clone https://github.com/nodenv/node-build.git "$(nodenv root)"/plugins/node-build
git clone https://github.com/nodenv/nodenv-update.git "$(nodenv root)"/plugins/nodenv-update


echo "done!"

echo "loading zshrc..."
sudo chmod 755 $HOME/.zshrc
source $HOME/.zshrc
echo "done!"

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
