echo "Setting up your Mac..."


DOT_DIRECTORY=$HOME/dotfiles
# zsh.zh実行
echo "Setting zsh..."
$DOT_DIRECTORY/zsh/set.sh
echo "Setting vim..."
$DOT_DIRECTORY/vim/set.sh
echo "Setting Alacritty"
$DOT_DIRECTORY/alacritty/set.sh

echo "Finished!! Let's go!!"
