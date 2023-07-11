#!/bin/bash

# Update Homebrew recipes
brew update-reset && brew update

# Install Rosetta
sudo softwareupdate --install-rosetta

# Install zsh
rm $HOME/.Brewfile
ln -s $HOME/dotfiles/zsh/Brewfile $HOME/.Brewfile
brew bundle --global

# install java
ln -sfn $(brew --prefix)/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

echo "change default shell \"zsh\"..."
zshPass=`dirname $(which brew)`/zsh
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
  # https://github.com/zplug/installer
  echo "download zplug"
  sudo mkdir -p /usr/local/opt
  sudo chmod 777 /usr/local/opt/zplug
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
  source /usr/local/opt/zplug/init.zsh
fi

echo "installing envs"
rm -rf $HOME/.goenv
git clone git@github.com:syndbg/goenv.git $HOME/.goenv
goenv install 1.18.2
goenv global 1.18.2

rm -rf $HOME/.nodenv
git clone git@github.com:nodenv/nodenv.git $HOME/.nodenv
cd $HOME/.nodenv && src/configure && make -C src
mkdir -p "$(nodenv root)"/plugins
git clone git@github.com:nodenv/node-build.git "$(nodenv root)"/plugins/node-build
git clone git@github.com:nodenv/nodenv-update.git "$(nodenv root)"/plugins/nodenv-update
nodenv install 16.1.0
nodenv global 16.1.0

rm -rf $HOME/.pyenv
git clone git@github.com:pyenv/pyenv.git $HOME/.pyenv
cd $HOME/.pyenv && src/configure && make -C src

echo "done!"

echo "loading zshrc..."
sudo chmod 755 $HOME/.zshrc
source $HOME/.zshrc
echo "done!"

echo "changing terminal theme..."
PURE=$HOME/.zplug/repos/sindresorhus/pure
rm $PURE/pure.plugin.zsh

ln -s $HOME/dotfiles/zsh/pure.plugin.zsh $PURE/pure.plugin.zsh
echo "done!"
