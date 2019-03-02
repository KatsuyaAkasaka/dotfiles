HERE=$HOME/dotfiles/vim

rm -rf $HOME/.vim

mkdir $HOME/.vim
echo "changing vim theme..."
COLOR=$HERE/colors
SETCOLOR=$HOME/.vim/colors
ln -s $COLOR $SETCOLOR

echo "loading package..."
DEIN=$HERE/dein
SETDEIN=$HOME/.vim/repos
ln -s $DEIN $SETDEIN

echo "loading vimrc..."
VIMRC=$HERE/.vimrc
SETVIMRC=$HOME/.vimrc
rm $SETVIMRC
ln -s $VIMRC $SETVIMRC

