filetype plugin indent on

" syntax enable

set autoindent          "改行時に前の行のインデントを計測
set smartindent         "改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smarttab            "新しい行を作った時に高度な自動インデントを行う
set expandtab           "タブ入力を複数の空白に置き換える

set tabstop=2           "タブを含むファイルを開いた際, タブを何文字の空白に変換するか
set shiftwidth=2        "自動インデントで入る空白数
set softtabstop=0       "キーボードから入るタブの数
set clipboard=unnamed,unnamedplus

" if has("autocmd")
"   "sw=softtabstop, sts=shiftwidth, ts=tabstop, et=expandtabの略
"   autocmd FileType c           setlocal sw=4 sts=4 ts=4 et
"   autocmd FileType html        setlocal sw=4 sts=4 ts=4 et
"   autocmd FileType ruby        setlocal sw=2 sts=2 ts=2 et
"   autocmd FileType js          setlocal sw=2 sts=2 ts=2 et
"   autocmd FileType go          setlocal sw=4 sts=4 ts=4
"   autocmd FileType zsh         setlocal sw=4 sts=4 ts=4 et
"   autocmd FileType python      setlocal sw=4 sts=4 ts=4 et
"   autocmd FileType scala       setlocal sw=4 sts=4 ts=4 et
"   autocmd FileType json        setlocal sw=4 sts=4 ts=4 et
"   autocmd FileType html        setlocal sw=4 sts=4 ts=4 et
"   autocmd FileType css         setlocal sw=4 sts=4 ts=4 et
"   autocmd FileType scss        setlocal sw=4 sts=4 ts=4 et
"   autocmd FileType sass        setlocal sw=4 sts=4 ts=4 et
"   autocmd FileType javascript  setlocal sw=2 sts=2 ts=2 et
"   autocmd FileType js,javascript  syntax sync fromstart
" endif

au BufRead,BufNewFile *.go set &filetype=go
au BufRead,BufNewFile *.ts set &filetype=typescript
au BufRead,BufNewFile *.js set &filetype=javascript

set incsearch

set ignorecase
set smartcase

" highlight search result
set hlsearch

" row number
set number

" highlight row number
set cursorline

set fileencoding=utf-8
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
set fileformats=unix,dos,mac

" no swap file
set nobackup
set noswapfile

set mouse=a

" change file realtime
set autoread

" background transparent
" highlight Normal ctermbg=none
" highlight NonText ctermbg=none
" highlight LineNr ctermbg=none
" highlight Folded ctermbg=none
" status line row
set laststatus=2

set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=dark
let g:one_allow_italics = 1
colorscheme vim-material
set t_Co=256

let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
