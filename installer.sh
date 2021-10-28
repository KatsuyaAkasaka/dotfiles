echo "Installing your essencialy package to this mahine..."


DOT_DIRECTORY=$HOME/dotfiles

echo "Setting vim..."
$DOT_DIRECTORY/vim/setup.sh
echo "Setting zsh..."
$DOT_DIRECTORY/zsh/setup.sh

echo "Finished!! Let's go!!"
