augroup spacevim_layer_lang_rust
	au FileType rust nmap <buffer><silent> gd <Plug>(rust-def)
	au FileType rust nmap <buffer><silent> gs <Plug>(rust-def-split)
	au FileType rust nmap <buffer><silent> gx <Plug>(rust-def-vertical)
	au FileType rust nmap <buffer><silent> <leader>gd <Plug>(rust-doc)
augroup END
