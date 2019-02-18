echo "Setting up your Mac..."

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle

# Make ZSH the default shell environment
chsh -s /ust/local/bin/zsh
# remove current .zshrc
rm -rf $HOME/.zshrc
# download zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
# install zplug
zplug install
DOT_DIRECTORY=$HOME/dotfiles
echo "DOT_DIRECTORY = "$DOT_DIRECTORY
for f in .??*
do
	echo "f = "$f
	echo "path = "$DOT_DIRECTORY/$f
	[[ "$f" == ".git" ]] && continue
	[[ "$f" == ".DS_Store" ]] && continue

	ln -s $DOT_DIRECTORY/$f $HOME/$f
done
