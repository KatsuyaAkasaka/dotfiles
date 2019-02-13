if &compatible
	set nocompatible               " Be iMproved
endif
" ----------dein----------
" Required:
  set runtimepath+=/Users/sakas/.cache/dein/repos/github.com/Shougo/dein.vim
" Required:
	let s:dein_dir = expand('~/.cache/dein')
	if dein#load_state(s:dein_dir)
		call dein#begin(s:dein_dir)

		let g:rc_dir = expand('~/.config/nvim')
	  let s:toml   = g:rc_dir . '/dein.toml'
	  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

	  call dein#load_toml(s:toml,      {'lazy': 0})
	  call dein#load_toml(s:lazy_toml, {'lazy': 1})

	  " Required:
	  call dein#end()
	  call dein#save_state()
	endif " Required:
	" filetype plugin indent on

	filetype plugin indent on 
	syntax on
	" If you want to install not installed plugins on startup

	if has('vim_starting') && dein#check_install()
		call dein#install()
	endif

	"----------plugins--------------

	" ----nerdtree----
	let g:NERDTreeDirArrows = 1
	" let g:NERDTreeDirArrowExpandable  = ''
	" let g:NERDTreeDirArrowCollapsible = ''
	let NERDTreeShowHidden=1

	" ----cawvim----

	" ----nerdcommenter----
	let g:NERDCreateDefaultMappings = 0
	let g:NERDDefaultAlign='left'
	let g:NERDSpaceDelims = 1

	" ----vim-indent-guides----
	let g:indent_guides_enable_on_vim_startup = 1
	set tabstop=2
	set shiftwidth=2

	" ----syntastic----
	let g:syntastic_enable_signs = 1
	let g:syntastic_always_populate_loc_list = 1
	let g:syntastic_auto_loc_list = 0
	let g:syntastic_check_on_open = 1
	let g:syntastic_javascript_checkers=['eslint']

	" ----neocomplete----
	" Disable AutoComplPop.
	let g:acp_enableAtStartup = 0
	" Use neocomplete.
	let g:neocomplete#enable_at_startup = 1
	" Use smartcase.
	let g:neocomplete#enable_smart_case = 1
	" Set minimum syntax keyword length.
	let g:neocomplete#sources#syntax#min_keyword_length = 2
	" Define dictionary.
	let g:neocomplete#sources#dictionary#dictionaries = {
		\ 'default' : '',
		\ 'vimshell' : $HOME.'/.vimshell_hist',
		\ 'scheme' : $HOME.'/.gosh_completions'
			\ }
			" Define keyword.
			if !exists('g:neocomplete#keyword_patterns')
			let g:neocomplete#keyword_patterns = {}
			endif
			let g:neocomplete#keyword_patterns['default'] = '\h\w*'
			" Enable omni completion.
			if !exists('g:neocomplete#sources#omni#input_patterns')
			let g:neocomplete#sources#omni#input_patterns = {}
			endif
			imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
			imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"

			" ----lightline----
			let g:lightline = {
				\ 'colorscheme': 'seoul256',
				\ 'mode_map': {'c': 'NORMAL'},
				\ 'active': {
					\   'right': [ [ 'syntastic', 'lineinfo' ],
					\              [ 'percent' ], [ 'winform' ],
					\              [ 'fileformat', 'fileencoding', 'filetype' ] ],
					\   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'branch', 'filename' ] ]
						\ },
				\ 'component_function': {
					\   'linetotal': 'LightLineTotal',
					\   'modified': 'LightLineModified',
					\   'readonly': 'LightLineReadonly',
					\   'fugitive': 'LightLineFugitive',
					\   'filename': 'LightLineFilename',
					\   'filepath': 'LightLineFilepath',
					\   'fileformat': 'LightLineFileformat',
					\   'filetype': 'LightLineFiletype',
					\   'fileencoding': 'LightLineFileencoding',
					\   'mode': 'LightLineMode',
					\   'winform': 'LightLineWinform'
						\ },
				\ 'separator': { 'left': "\u2b80", 'right': "\u2b82" },
				\ 'subseparator': { 'left': "\u2b81", 'right': "\u2b83" },
				\ 'component_expand': {
					\   'syntastic': 'SyntasticStatuslineFlag',
					\ },
				\ 'component_type': {
					\   'syntastic': 'error',
					\ }
				\ }

function! LightLineWinform()
	return winwidth(0) > 50 ? 'w' . winwidth(0) . ':' . 'h' . winheight(0) : ''
endfunction

function! LightLineModified()
	return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
	return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? "⭤" : ''
endfunction

function! LightLineFilename()
	return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
	\ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
			\  &ft == 'unite' ? unite#get_status_string() :
			\  &ft == 'vimshell' ? vimshell#get_status_string() :
			\ '' != expand('%') && winwidth(0) <=120 ? expand('%:t') : winwidth(0) >120 ? expand('%:p') : '[No Name]') .
	\ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFilepath()
	return winwidth(0) <=120 ? expand('%:h') : ''
endfunction

function! LightLineFugitive()
	try
		if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head') && winwidth(0) > 55
			let _ = fugitive#head()
			return strlen(_) ? '⭠ '._ : ''
		endif
	catch
	endtry
	return ''
endfunction

function! LightLineFileformat()
	return winwidth(0) > 80 ? &fileformat : ''
	endfunction

function! LightLineFiletype()
	return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
	endfunction

function! LightLineFileencoding()
	return winwidth(0) > 60 ? (strlen(&fenc) ? &fenc : &enc) : ''
	endfunction

function! LightLineMode()
	return winwidth(0) > 30 ? lightline#mode() : ''
endfunction

function! s:syntastic()
	SyntasticCheck
	call lightline#update()
endfunction

	"----keymap----
	let mapleader="\<Space>"
	set clipboard=unnamed
	nnoremap s <Nop>
	nnoremap ss :<C-u>sp<CR>
	nnoremap sv :<C-u>vs<CR>
	nnoremap <CR> i<CR><ESC>:<C-u>w<CR>
	nnoremap <Leader>s :<C-u>w<CR>
	nnoremap <Leader>w :<C-u>wq<CR>
	nnoremap <Leader>q :<C-u>q<CR>
	nnoremap <Leader><Leader> <S-g><S-v>gg=:<C-u>w<CR>
	nnoremap <TAB> I<TAB><ESC>:<C-u>w<CR>
	inoremap <silent> jj <ESC>:<C-u>w<CR>
	nnoremap j gj
	nnoremap k gk
	nnoremap gj j
	nnoremap gk k
	nnoremap x "_x
	noremap <S-h> ^
	noremap <S-j> }
	noremap <S-k> {
	noremap <S-l> $
	nnoremap <silent> <C-e> :NERDTreeToggle<CR>
	nmap <Leader>/ <Plug>NERDCommenterToggle:<C-u>w<CR>
	vmap <Leader>/ <Plug>NERDCommenterInvert:<C-u>w<CR>
	nnoremap <Space>g :vim <C-r><C-w> %<CR>
	nnoremap N :cprevious<CR>
	nnoremap n :cnext<CR>
	" ----others----
	set fileencoding=utf-8
	set fileencodings=ucs-boms,utf-8,euc-jp,cp932
	set fileformats=unix,dos,mac
	set ambiwidth=double

	set tabstop=2
	set softtabstop=2
	set smartindent
	set shiftwidth=2
	set incsearch
	set ignorecase
	set smartcase
	" highlight search result
	set hlsearch

	" no swap file
	set backspace=2

	" background theme
	colorscheme gruvbox
	let g:gruvbox_contrast = 'hard'
	highlight StatusLine ctermfg=darkblue
	highlight StatusLine ctermbg=black
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
	let &t_SI = "\<Esc>]50;CursorShape=1\x7"
	let &t_EI = "\<Esc>]50;CursorShape=0\x7"

	set lines=800
	set columns=100

	" hi MatchParen cterm=bold ctermbg=239 ctermfg=177
	" hi Search ctermbg=177 ctermfg=239
