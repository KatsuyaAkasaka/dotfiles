if executable('gopls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'gopls',
        \ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
        \ 'whitelist': ['go'],
        \ })
endif
let g:lsp_signs_enabled = 1         " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
let g:lsp_diagnostics_enabled = 0         " disable diagnostics support
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '!'} " icons require GUI
let g:lsp_signs_hint = {'text': '?'} " icons require GUI
