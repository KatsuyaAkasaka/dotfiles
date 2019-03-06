let g:gitgutter_enabled = 1
set signcolumn=yes
set updatetime=1000
highlight clear SignColumn
autocmd ColorScheme * highlight GitGutterAdd ctermfg=78
highlight GitGutterChange ctermfg=214
highlight GitGutterDelete ctermfg=197
highlight GitGutterChangeDelete ctermfg=197
let g:gitgutter_sign_added = '.'
let g:gitgutter_sign_modified = '.'
let g:gitgutter_sign_removed = '.'
let g:gitgutter_sign_removed_first_line = '.'
let g:gitgutter_sign_modified_removed = '.'
