TMUX=$HOME/dotfiles/tmux

echo "tmux setting"
rm $HOME/.tmux.conf
ln -s $TMUX/.tmux.conf $HOME/.tmux.conf
