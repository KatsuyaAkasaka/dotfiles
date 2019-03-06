if &compatible
	set nocompatible
endif

" ----------dein----------

" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
	call dein#begin(s:dein_dir)

	let g:rc_dir = expand('~/.vim/repos')
	let s:toml   = g:rc_dir . '/dein.toml'
	let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

	call dein#load_toml(s:toml,      {'lazy': 0})
	call dein#load_toml(s:lazy_toml, {'lazy': 1})

	call dein#end()
	call dein#save_state()
endif

" If you want to install not installed plugins on startup

if has('vim_starting') && dein#check_install()
	call dein#install()
endif

"----------plugins--------------

filetype plugin indent on 
syntax enable

"----keymap----
let mapleader="\<Space>"
set clipboard=unnamed
nnoremap s <Nop>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sJ <C-w>-
nnoremap sK <C-w>+
nnoremap s> <C-w>>
nnoremap s< <C-w><
nnoremap <Leader>t :<C-u>tabnew<CR>
nnoremap <Leader>l gt 
nnoremap <Leader>h gT 
nnoremap <CR> i<CR><ESC>
nnoremap <Leader>s :<C-u>w<CR>
nnoremap <Leader>w :<C-u>wq<CR>
nnoremap <Leader>q :<C-u>q!<CR>
nnoremap <TAB> I<TAB><ESC>
inoremap <silent> jj <ESC>
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
nnoremap x "_x
noremap <S-h> ^
noremap <S-j> }
noremap <S-k> {
noremap <S-l> $
nnoremap <silent> <C-e> :<C-u>NERDTreeToggle<CR>
nmap <Leader>/ <Plug>NERDCommenterToggle:<C-u>w<CR>
vmap <Leader>/ <Plug>NERDCommenterInvert:<C-u>w<CR>
nnoremap <Leader>p :<C-u>Files<CR>
nnoremap <Leader>g :<C-u>GFiles?<CR>
nnoremap <Leader>f :<C-u>Rg<CR>


" ----others----
set fileencoding=utf-8
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
set fileformats=unix,dos,mac
set ambiwidth=double

set tabstop=2
set shiftwidth=2
set smartindent
set incsearch
set ignorecase
set smartcase
" highlight search result
set hlsearch

" no swap file
set nobackup
set noswapfile

" set backspace
set backspace=2

" background theme
set termguicolors
autocmd ColorScheme * highlight Normal guibg=NONE
autocmd ColorScheme * highlight LineNr guibg=NONE
let g:material_style='palenight'
set background=dark
colorscheme vim-material
" let g:material_theme_style = 'palenight'
" let g:gruvbox_contrast = 'hard'
set t_Co=256

" background transparent
highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none
highlight Folded ctermbg=none
" row number
set number
" highlight row number 
set cursorline
" status line row
set laststatus=2
" change file realtime
set autoread

" change cursor shape
" let &t_SI = "\<Esc>]50;CursorShape=1\x7"
" let &t_EI = "\<Esc>]50;CursorShape=0\x7"

let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

set lines=800
set columns=100

set mouse=a

" hi MatchParen cterm=bold ctermbg=239 ctermfg=177
" hi Search ctermbg=177 ctermfg=239
function! s:get_syn_id(transparent)
	let synid = synID(line("."), col("."), 1)
	if a:transparent
		return synIDtrans(synid)
	else
		return synid
	endif
endfunction
function! s:get_syn_attr(synid)
	let name = synIDattr(a:synid, "name")
	let ctermfg = synIDattr(a:synid, "fg", "cterm")
	let ctermbg = synIDattr(a:synid, "bg", "cterm")
	let guifg = synIDattr(a:synid, "fg", "gui")
	let guibg = synIDattr(a:synid, "bg", "gui")
	return {
				\ "name": name,
				\ "ctermfg": ctermfg,
				\ "ctermbg": ctermbg,
				\ "guifg": guifg,
				\ "guibg": guibg}
endfunction
function! s:get_syn_info()
	let baseSyn = s:get_syn_attr(s:get_syn_id(0))
	echo "name: " . baseSyn.name .
				\ " ctermfg: " . baseSyn.ctermfg .
				\ " ctermbg: " . baseSyn.ctermbg .
				\ " guifg: " . baseSyn.guifg .
				\ " guibg: " . baseSyn.guibg
	let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
	echo "link to"
	echo "name: " . linkedSyn.name .
				\ " ctermfg: " . linkedSyn.ctermfg .
				\ " ctermbg: " . linkedSyn.ctermbg .
				\ " guifg: " . linkedSyn.guifg .
				\ " guibg: " . linkedSyn.guibg
endfunction
command! SyntaxInfo call s:get_syn_info()


