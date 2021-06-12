HERE=$HOME/dotfiles/vim

rm -rf $HOME/.vim
rm -f $HOME/.vimrc
rm -rf $HOME/.config/nvim

mkdir $HOME/.vim
mkdir -p $HOME/.config/nvim

# echo "loading package..."
# DEIN=$HERE/dein
# SETDEIN=$HOME/.vim/repos
# ln -s $DEIN $SETDEIN

echo "changing vim theme..."
COLOR=$HERE/colors
SETCOLOR=$HOME/.vim/colors
ln -s $COLOR $SETCOLOR

echo "changing vim syntax..."
SYNTAX=$HERE/syntax
SETSYNTAX=$HOME/.vim/syntax
ln -s $SYNTAX $SETSYNTAX

echo "loading rc..."
RC=$HERE/rc
SETRC=$HOME/.vim/rc
SETRCN=$HOME/.config/nvim/rc
ln -s $RC $SETRC
ln -s $RC $SETRCN

echo "loading plugins..."
PLUGINS=$HERE/plugins
SETPLUG=$HOME/.vim/plugins
SETPLUGN=$HOME/.config/nvim/plugins
ln -s $PLUGINS $SETPLUG
ln -s $PLUGINS $SETPLUGN

echo "loading vimrc..."
VIMRC=$HERE/.vimrc
SETVIMRC=$HOME/.vimrc
ln -s $VIMRC $SETVIMRC

echo "loading init.vim..."
INITVIM=$HERE/init.vim
SETINIT=$HOME/.config/nvim/init.vim
ln -s $INITVIM $SETINIT
