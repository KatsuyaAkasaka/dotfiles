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
nnoremap <Leader>p :bp<CR>
nnoremap <Leader>n :bn<CR>
nnoremap <Leader>w :<C-u>wq<CR>
nnoremap <Leader>q :<C-u>q!<CR>
nnoremap <TAB> I<TAB><ESC>
inoremap <silent> jj <ESC>
nnoremap j gj
nnoremap k gk
nnorema  gj j
nnoremap gk k
nnoremap x "_x
noremap <S-h> ^
noremap <S-j> }
noremap <S-k> {
noremap <S-l> $
nnoremap <silent> <C-e> :<C-u>NERDTreeToggle<CR>
" nmap <Leader>/ <Plug>NERDComComment:<C-u>w<CR>
vmap <Leader>/ <Plug>NERDComToggleComment:<C-u>w<CR>
nnoremap <Leader>p :<C-u>Files<CR>
nnoremap <Leader>g :<C-u>GFiles?<CR>
nnoremap <Leader>f :<C-u>Rg<CR>
nmap <Esc><Esc> :nohlsearch<CR><Esc> 
nnoremap <buffer> gd :<C-u>LspDefinition<CR>


" クリップボードにコピー
set clipboard=unnamed
" ファイル保存時のエンコーディング形式
set fileencoding=utf-8
" ファイル読み込み時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
" 日本語の文字コードを自動判別
set fileformats=unix,dos,mac
" 全角文字を正しく表示させるため
set ambiwidth=double
" 画面上でタブが占める割合
set tabstop=2
" shiftの幅
set shiftwidth=2
" インデントの増減をよしなにする
set smartindent
" 大文小文字を検索時に考慮しない
set ignorecase
" 大文字入ってきたときにはそれを考慮した検索結果を返す
set smartcase
" チルダファイル作成無効
set nobackup
" swpファイル無効
set noswapfile

" background theme
set termguicolors
autocmd ColorScheme * highlight Normal guibg=NONE
autocmd ColorScheme * highlight LineNr guibg=NONE
let g:material_style='palenight'
set background=dark
colorscheme vim-material
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
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

set lines=53
set columns=191

set mouse=a

