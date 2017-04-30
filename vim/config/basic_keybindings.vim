 "{ personal key-bindings
  nnoremap Y y$
  nnoremap <F10> :NERDTreeToggle<cr>

  inoremap <C-h> <C-o>h
  inoremap <C-l> <C-o>a
  inoremap <C-j> <C-o>j
  inoremap <C-k> <C-o>k

  " Save a file with sudo
  " http://forrst.com/posts/Use_w_to_sudo_write_a_file_with_Vim-uAN
  cnoremap w!! %!sudo tee > /dev/null %

  " Use Ctrl+* to jump between windows
  nnoremap <silent><C-Right> :<C-u>wincmd l<CR>
  nnoremap <silent><C-Left>  :<C-u>wincmd h<CR>
  nnoremap <silent><C-Up>    :<C-u>wincmd k<CR>
  nnoremap <silent><C-Down>  :<C-u>wincmd j<CR>

  if has('nvim')
    exe 'tnoremap <silent><C-Right> <C-\><C-n>:<C-u>wincmd l<CR>'
    exe 'tnoremap <silent><C-Left>  <C-\><C-n>:<C-u>wincmd h<CR>'
    exe 'tnoremap <silent><C-Up>    <C-\><C-n>:<C-u>wincmd k<CR>'
    exe 'tnoremap <silent><C-Down>  <C-\><C-n>:<C-u>wincmd j<CR>'
    exe 'tnoremap <silent><M-Left>  <C-\><C-n>:<C-u>bprev<CR>'
    exe 'tnoremap <silent><M-Right>  <C-\><C-n>:<C-u>bnext<CR>'
    exe 'tnoremap <silent><esc>     <C-\><C-n>'
  endif

  "Quickly add empty lines
  nnoremap <silent>[<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>
  nnoremap <silent>]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

  "Use jk switch to normal mode
  inoremap jk <esc>

  "]e or [e move current line ,count can be useed
  nnoremap <silent>[e  :<c-u>execute 'move -1-'. v:count1<cr>
  nnoremap <silent>]e  :<c-u>execute 'move +'. v:count1<cr>

  " ----------------------------------------------------------------------------
  " Quickfix
  " ----------------------------------------------------------------------------
  nnoremap ]q :cnext<cr>zz
  nnoremap [q :cprev<cr>zz
  nnoremap ]l :lnext<cr>zz
  nnoremap [l :lprev<cr>zz

  " ----------------------------------------------------------------------------
  " Buffers
  " ----------------------------------------------------------------------------
  nnoremap ]b :bnext<cr>
  nnoremap [b :bprev<cr>

  " ----------------------------------------------------------------------------
  " Tabs
  " ----------------------------------------------------------------------------
  nnoremap ]t :tabn<cr>
  nnoremap [t :tabp<cr>

  " Select blocks after indenting
  xnoremap < <gv
  xnoremap > >gv|

  " Use tab for indenting in visual mode
  xnoremap <Tab> >gv|
  xnoremap <S-Tab> <gv
  nnoremap > >>_
  nnoremap < <<_

  " Select last paste
  nnoremap <silent><expr> gp '`['.strpart(getregtype(), 0, 1).'`]'

  " Use Q format lines
  map Q @q
  " Allow using the repeat operator with a visual selection (!)
  vnoremap . :normal .<CR>
  cmap cwd lcd %:p:h

  " Navigate window
  "nnoremap <silent><C-q> <C-w>
  "nnoremap <silent><C-x> <C-w>x

  " Navigation in command line
  " cnoremap <C-a> <Home>
  " cnoremap <C-b> <Left>
  " cnoremap <C-f> <Right>
  " cnoremap <expr> <C-d> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"

  vmap v <PLUG>(expand_region_expand)
  vmap V <PLUG>(expand_region_shrink)

  " Start interactive EasyAlign with a Vim movement
  xmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)

  " Remove spaces at the end of lines
  " nnoremap <silent> ,<Space> :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>

  " C-r: Easier search and replace
  xnoremap <C-r> :<C-u>call <SID>VSetSearch()<CR>:,$s/<C-R>=@/<CR>//gc<left><left><left>
  function! s:VSetSearch() abort
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
    let @s = temp
  endfunction

  nnoremap <silent> g= :call <SID>BufferFormat()<CR>
  function! s:BufferFormat() abort
    let save_cursor = getcurpos()
    normal! gg=G
    call setpos('.', save_cursor)
  endfunction
" }

