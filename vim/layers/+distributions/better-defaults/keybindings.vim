" Reload .vimrc
" basic leader related keybindings
"
nnoremap <Leader>feR :source $MYVIMRC<CR>
nnoremap <Leader>fed :edit $MYVIMRC<CR>

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

map  gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine

" vim-better-whitespace
nnoremap <Leader>xd :call StripTrailingWhitespace()<CR>

nnoremap <Leader>wm :only<CR>
nnoremap <Leader>w- :split<CR>
nnoremap <Leader>w/ :vsplit<CR>
nnoremap <Leader>wq :close<CR>
nnoremap <Leader>ww :wincmd w<CR>

"for buftabs
noremap <Leader>bp :bprev<CR>
noremap <Leader>bn :bnext<CR>
noremap <Leader>bd :bdelete<CR>

noremap <Leader>fs :write<CR>
noremap <Leader>fS :wall<CR>
noremap <Leader>fR :call feedkeys(":Rename ")<CR>

nmap <Leader>ts :setlocal spell!<cr>
nmap <Leader>tn :setlocal nonumber! norelativenumber!<CR>
nmap <Leader>tl :setlocal nolist!<CR>
nmap <Leader>th :nohlsearch<CR>
nmap <Leader>tw :setlocal wrap! breakindent!<CR>

nmap <Leader>ss [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" yark and paste
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

nnoremap <Leader>q :q<CR>
nnoremap <Leader>qa :qa<CR>

" http://vimcasts.org/e/14
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ff :e %%
"map <leader>es :sp %%
"map <leader>ev :vsp %%
"map <leader>et :tabe %%

"map <Leader>cd :cd %:p:h<CR>:pwd<CR>

"background
noremap <silent><leader>bg :call <SID>ToggleBG()<CR>
function! s:ToggleBG()
	let s:tbg = &background
	" Inversion
	if s:tbg == "dark"
		set background=light
	else
		set background=dark
	endif
endfunction
