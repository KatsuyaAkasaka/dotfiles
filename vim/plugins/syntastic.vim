" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" 
" let g:syntastic_always_populate_loc_list = 0
" let g:syntastic_auto_loc_list = 0
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" 
" let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': [
"   \ 'ruby', 'javascript','coffee', 'scss', 'html', 'haml', 'slim', 'sh',
"   \ 'spec', 'vim', 'zsh', 'sass', 'eruby'] }
" 
" let g:syntastic_javascript_checkers=['eslint']
" let g:syntastic_coffee_checkers = ['coffeelint']
" let g:syntastic_scss_checkers = ['scss_lint']
" let g:syntastic_ruby_checkers = ['rubocop']
" 
"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_highlighting = 1
let g:syntastic_go_checkers = ['golint']
let g:syntastic_error_symbol='✗'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_style_warning_symbol = '⚠'

" highlight SyntasticErrorSign guifg=white guibg=red
" highlight SyntasticErrorLine guibg=#2f0000
