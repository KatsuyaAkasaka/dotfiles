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
chsh -s $(which zsh)
# remove current .zshrc
rm -rf $HOME/.zshrc

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
