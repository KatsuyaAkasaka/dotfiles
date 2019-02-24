#!/usr/local/bin/zsh

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew recipes
brew update

# Install zsh
# brew bundle

# Make ZSH the default shell environment
chsh -s /usr/local/bin/zsh
# remove current .zshrc
if [[ -e $HOME/.zshrc ]]; then
	rm -rf $HOME/.zshrc
fi
ln -s $HOME/dotfiles/zsh/.zshrc $HOME/.zshrc
# download zplug

if [[ ! -e $HOME/.zplug ]]; then
	curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
fi

source $HOME/.zshrc

PURE=$HOME/.zplug/repos/sindresorhus/pure
rm $PURE/pure.plugin.zsh

ln -s $HOME/dotfiles/zsh/pure.plugin.zsh $PURE/pure.plugin.zsh
