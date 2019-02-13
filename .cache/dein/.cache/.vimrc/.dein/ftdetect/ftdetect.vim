autocmd BufReadPost *.fugitiveblame setfiletype fugitiveblame
" Detect syntax file.
autocmd BufNewFile,BufRead *.snip,*.snippets set filetype=neosnippet
" Detect vimshell rc file.
autocmd BufNewFile,BufRead *.vimsh,.vimshrc,vimshrc set filetype=vimshrc
