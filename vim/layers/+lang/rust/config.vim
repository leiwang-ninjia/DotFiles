augroup spacevimRust
  autocmd BufEnter *.rs nnoremap <LocalLeader>r :call spacevim#lang#rust#Run()<CR>
  autocmd BufEnter *.rs nnoremap <LocalLeader>b :call spacevim#lang#rust#Build()<CR>
	au FileType rust nmap <buffer><silent> gd <Plug>(rust-def)
	au FileType rust nmap <buffer><silent> gs <Plug>(rust-def-split)
	au FileType rust nmap <buffer><silent> gx <Plug>(rust-def-vertical)
	au FileType rust nmap <buffer><silent> <leader>gd <Plug>(rust-doc)
augroup END

