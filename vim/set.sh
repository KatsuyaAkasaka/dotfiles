HERE=$HOME/dotfiles/vim

rm -rf $HOME/.vim
rm -rf $HOME/.config/nvim

mkdir $HOME/.vim
mkdir -p $HOME/.config/nvim

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

echo "loading init.vim..."
INITVIM=$HERE/init.vim
SETINIT=$HOME/.config/nvim/init.vim
rm $SETINIT
ln -s $INITVIM $SETINIT

echo "loading plugins..."
PLUGINS=$HERE/plugins
SETPLUG=$HOME/.config/nvim/plugins
rm $PLUGINS
ln -s $PLUGINS $SETPLUG
