echo "Installing your essencialy package to this mahine..."


DOT_DIRECTORY=$HOME/dotfiles
# zsh.zh実行
echo "Setting vim..."
$DOT_DIRECTORY/vim/set.sh
echo "Setting zsh..."
$DOT_DIRECTORY/zsh/set.sh

echo "Finished!! Let's go!!"
