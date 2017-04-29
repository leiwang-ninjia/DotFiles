" Reload .vimrc
nnoremap <Leader>fR :source $MYVIMRC<CR>

" <Leader>[1-9] move to window [1-9]
for s:i in range(1, 9)
    execute 'nnoremap <Leader>' . s:i . ' :' . s:i . 'wincmd w<CR>'
endfor

" <Leader>b[1-9] move to buffer [1-9]
for s:i in range(1, 9)
    execute 'nnoremap <Leader>b' . s:i . ' :b' . s:i . '<CR>'
endfor

" Startify
nnoremap <silent><Leader>bh :Startify<CR>

" vim-better-whitespace
nnoremap <Leader>xd :call StripTrailingWhitespace()<CR>
nnoremap <Leader>wm :only<CR>

map  gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine

