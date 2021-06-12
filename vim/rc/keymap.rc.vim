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
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
