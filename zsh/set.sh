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
# /usr/local/bin/zsh
# Make ZSH the default shell environment
grep /usr/local/bin/zsh -rl /etc/shells
ref=$?
if [ $ref -ne 0 ]; then
	echo "set up zsh to default"
	sudo chmod 777 /etc/shells
	sh -c "echo /usr/local/bin/zsh >> /etc/shells"
	sudo chmod 755 /etc/shells
fi
chsh -s /usr/local/bin/zsh


# remove current .zshrc
if [[ -e $HOME/.zshrc ]]; then
	rm -rf $HOME/.zshrc
fi
ln -s $HOME/dotfiles/zsh/.zshrc $HOME/.zshrc
# download zplug
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
