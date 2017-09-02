" Reload .vimrc
" basic leader related keybindings
"
nnoremap <Leader>feR :source $MYVIMRC<CR>
nnoremap <Leader>fed :edit $MYVIMRC<CR>

" <Leader>[1-9] move to window [1-9]
for s:i in range(1, 9)
  execute 'nnoremap <Leader>' . s:i . ' :' . s:i . 'wincmd w<CR>'
endfor

" <Leader><leader>[1-9] move to tab [1-9]
for s:i in range(1, 9)
  execute 'nnoremap <Leader><Leader>' . s:i . ' ' . s:i . 'gt'
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
" util
nnoremap <Leader>tc :call spacevim#util#ToggleCursorColumn()<CR>
nnoremap <Leader>tC :call spacevim#util#ToggleColorColumn()<CR>

command! -bar -nargs=0 Rtp :call spacevim#util#Runtimepath()
nnoremap <Leader>wm :only<CR>
nnoremap <Leader>w/ :vsplit<CR>
nnoremap <Leader>w- :split<CR>
nnoremap <Leader>w= :wincmd =<CR>
nnoremap <Leader>wc :close<CR>
nnoremap <Leader>ww :wincmd w<CR>
nnoremap <Leader>ws :split<CR>
nnoremap <Leader>wS :split<CR>
nnoremap <Leader>wv :vsplit<CR>
nnoremap <Leader>wV :vsplit<CR>

"for buftabs
nnoremap <Leader>bp :bprev<CR>
nnoremap <Leader>bn :bnext<CR>
nnoremap <Leader>bd :bdelete<CR>

nnoremap <Leader>fs :write<CR>
nnoremap <Leader>fS :wall<CR>
nnoremap <Leader>fR :call feedkeys(":Rename ")<CR>

nnoremap <Leader>tS :setlocal spell!<cr>
nnoremap <Leader>tn :setlocal norelativenumber!<CR>
nnoremap <Leader>tr :setlocal norelativenumber!<CR>
nnoremap <Leader>tl :setlocal nolist!<CR>
nnoremap <Leader>th :nohlsearch<CR>
nnoremap <Leader>tw :setlocal wrap! breakindent!<CR>

nnoremap <Leader>j= mzgg=G`z
vnoremap <Leader>j= ==

map <Leader>jj i<CR><Esc>
map <Leader>jJ i<CR><Esc>
map <Leader>jo i<CR><Esc>k$

nnoremap <leader>n- <C-x>
nnoremap <leader>n+ <C-a>
nnoremap <leader>n= <C-a>
nnoremap <leader>/ :Ag<CR>
nnoremap <leader>* :call SmartSearchWithInput(0)<CR>
vnoremap <leader>* :call SmartSearchWithInput(0)<CR>

nnoremap <Leader>ss [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" yark and paste
"vnoremap <Leader>y "+y
"vnoremap <Leader>d "+d
"nnoremap <Leader>p "+p
"nnoremap <Leader>P "+P
"vnoremap <Leader>p "+p
"vnoremap <Leader>P "+P

nnoremap <Leader>qq :qa<CR>
nnoremap <Leader>qQ :qa!<CR>
nnoremap <Leader>qs :xall<CR>

" http://vimcasts.org/e/14
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ff :e %%
if exists(':Files')
	map <leader>ff :Files %:h<CR>
else
	map <leader>ff :e %%<CR>
endif

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
