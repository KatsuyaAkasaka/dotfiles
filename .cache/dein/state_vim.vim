if g:dein#_cache_version !=# 100 || g:dein#_init_runtimepath !=# '/Users/sakas/.vim,/usr/local/share/vim/vimfiles,/usr/local/share/vim/vim81,/usr/local/share/vim/vimfiles/after,/Users/sakas/.vim/after,/Users/sakas/.cache/dein/repos/github.com/Shougo/dein.vim' | throw 'Cache loading error' | endif
let [plugins, ftplugin] = dein#load_cache_raw(['/Users/sakas/.vimrc', '/Users/sakas/.config/nvim/dein.toml', '/Users/sakas/.config/nvim/dein_lazy.toml'])
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/Users/sakas/.cache/dein'
let g:dein#_runtime_path = '/Users/sakas/.cache/dein/.cache/.vimrc/.dein'
let g:dein#_cache_path = '/Users/sakas/.cache/dein/.cache/.vimrc'
let &runtimepath = '/Users/sakas/.vim,/usr/local/share/vim/vimfiles,/Users/sakas/.cache/dein/repos/github.com/Shougo/dein.vim,/Users/sakas/.cache/dein/.cache/.vimrc/.dein,/usr/local/share/vim/vim81,/Users/sakas/.cache/dein/.cache/.vimrc/.dein/after,/usr/local/share/vim/vimfiles/after,/Users/sakas/.vim/after'
