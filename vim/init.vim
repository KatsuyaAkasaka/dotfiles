" Note: Skip initialization for vim-tiny or vim-small.
" profile start profile.txt
" profile file ~/.vim/rc/*
if 1
  execute 'source' fnamemodify(resolve(expand('<sfile>:p')), ':h').'/rc/vimrc'
endif
