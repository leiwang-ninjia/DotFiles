scriptencoding utf-8
function! SpaceVim#default#SetOptions() abort

  " basic vim settiing

  set nocompatible        " Must be first line

" General {

    " if !has('gui')
        "set term=$TERM          " Make arrow and other keys work
    " endif
    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    "scriptencoding utf-8

    if has('clipboard')
      if has('unnamedplus')  " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
      else         " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
      endif
    endif

    " Most prefer to automatically switch to the current file directory when
    " a new buffer is opened; to prevent this behavior, add the following to
    " your .vimrc.before.local file:
    "   let g:spf13_no_autochdir = 1
    if !exists('g:spf13_no_autochdir')
      autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
      " Always switch to the current file directory
    endif

    "set autowrite                       " Automatically write a file when leaving a modified buffer
    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore             " Allow for cursor beyond last character
    set history=1000                    " Store a ton of history (default is 20)
    "set spell                           " Spell checking on
    set hidden                          " Allow buffer switching without saving
    set iskeyword-=.                    " '.' is an end of word designator
    set iskeyword-=#                    " '#' is an end of word designator
    set iskeyword-=-                    " '-' is an end of word designator

    " http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
    " Restore cursor to file position in previous editing session
    " To disable this, add the following to your .vimrc.before.local file:
    "   let g:spf13_no_restore_cursor = 1
    if !exists('g:spf13_no_restore_cursor')
      function! ResCur()
        if line("'\"") <= line("$")
          silent! normal! g`"
          return 1
        endif
      endfunction

      augroup resCur
        autocmd!
        autocmd BufWinEnter * call ResCur()
      augroup END
    endif

    " Setting up the directories {
        "set backup                   Backups are nice ...
        "if has('persistent_undo')
            "set undofile                 So is persistent undo ...
            "set undolevels=1000          Maximum number of changes that can be undone
            "set undoreload=10000         Maximum number lines to save for undo on a buffer reload
        "endif

        " To disable views add the following to your .vimrc.before.local file:
        "   let g:spf13_no_views = 1
        if !exists('g:spf13_no_views')
            " Add exclusions to mkview and loadview
            " eg: *.*, svn-commit.tmp
            let g:skipview_files = [
                \ '\[example pattern\]'
                \ ]
        endif
    " }

" }

" Vim UI {

    if !exists('g:override_spf13_bundles') && filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
        let g:solarized_termcolors=256
        let g:solarized_termtrans=1
        let g:solarized_contrast="normal"
        let g:solarized_visibility="normal"
        color solarized             " Load a colorscheme
    endif

  if has('gui_running')
    set guioptions-=m " Hide menu bar.
    set guioptions-=T " Hide toolbar
    set guioptions-=L " Hide left-hand scrollbar
    set guioptions-=r " Hide right-hand scrollbar
    set guioptions-=b " Hide bottom scrollbar
    set showtabline=0 " Hide tabline
    if WINDOWS()
      " please install the font in 'Dotfiles\font'
      set guifont=DejaVu_Sans_Mono_for_Powerline:h11:cANSI:qDRAFT
    elseif OSX()
      set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h11
    else
      set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 11
    endif
  endif

  set tabpagemax=15               " Only show 15 tabs
  set showmode                    " Display the current mode

  set cursorline                  " Highlight current line

  highlight clear SignColumn      " SignColumn should match background
  highlight clear LineNr          " Current line number row will have same background color in relative mode

  if has('cmdline_info')
    set ruler                   " Show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
    set showcmd                 " Show partial commands in status line and
    " Selected characters/lines in visual mode
  endif

  if has('statusline')
    set laststatus=2

    " Broken down into easily includeable segments
    set statusline=%<%f\                     " Filename
    set statusline+=%w%h%m%r                 " Options
    if !exists('g:override_spf13_bundles')
      set statusline+=%{fugitive#statusline()} " Git Hotness
    endif
    set statusline+=\ [%{&ff}/%Y]            " Filetype
    set statusline+=\ [%{getcwd()}]          " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
  endif

  set backspace=indent,eol,start  " Backspace for dummies
  set linespace=0                 " No extra spaces between rows
  set linebreak                   " do not break words.
  set number                      " Line numbers on
  set relativenumber
  set showmatch                   " Show matching brackets/parenthesis
  set incsearch                   " Find as you type search
  set hlsearch                    " Highlight search terms
  set winminheight=0              " Windows can be 0 line high
  set ignorecase                  " Case insensitive search
  set smartcase                   " Case sensitive when uc present
  set wildmenu                    " Show list instead of just completing
  set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
  set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
  set scrolljump=5                " Lines to scroll when cursor leaves screen
  set scrolloff=3                 " Minimum lines to keep above and below cursor
  set foldenable                  " Auto fold code
  set list
  set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
  "hi VertSplit ctermbg=NONE guibg=NONE
  set fillchars+=vert:│

" }

" Formatting {

  set nowrap                      " Do not wrap long lines
  set autoindent                  " Indent at the same level of the previous line
  set shiftwidth=4                " Use indents of 4 spaces
  set smartindent
  "set cindent

  " tab options:
  set tabstop=4                   " An indentation every four columns
  "set expandtab                   " Tabs are spaces, not tabs
  set softtabstop=4               " Let backspace delete indent
  set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
  set splitright                  " Puts new vsplit windows to the right of the current
  set splitbelow                  " Puts new split windows to the bottom of the current
  set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)

"}

  " autoread
  set autoread

  " backup
  "set nobackup
  "set noundofile

  " no fold enable
  " set nofoldenable
  " set nowritebackup
  set matchtime=0
  "menuone: show the pupmenu when only one match
  " disable preview scratch window,
  set completeopt=menu,menuone,longest
  " h: 'complete'
  set complete=.,w,b,u,t
  " limit completion menu height
  set pumheight=15
  set laststatus=2
  set wildignorecase
  set ttimeout
  set ttimeoutlen=50
  set background=dark
endfunction

function! SpaceVim#default#SetPlugins() abort

"  call add(g:spacevim_plugin_groups, 'web')
  call add(g:spacevim_plugin_groups, 'lang')
  call add(g:spacevim_plugin_groups, 'edit')
  call add(g:spacevim_plugin_groups, 'ui')
  call add(g:spacevim_plugin_groups, 'tools')
  call add(g:spacevim_plugin_groups, 'checkers')
  call add(g:spacevim_plugin_groups, 'format')
  call add(g:spacevim_plugin_groups, 'git')
" call add(g:spacevim_plugin_groups, 'javascript')
" call add(g:spacevim_plugin_groups, 'ruby')
  call add(g:spacevim_plugin_groups, 'lang#python')
  "call add(g:spacevim_plugin_groups, 'scala')
  call add(g:spacevim_plugin_groups, 'lang#go')
  call add(g:spacevim_plugin_groups, 'lang#markdown')
  "call add(g:spacevim_plugin_groups, 'scm')
  "call add(g:spacevim_plugin_groups, 'editing')
  "call add(g:spacevim_plugin_groups, 'indents')
  "call add(g:spacevim_plugin_groups, 'navigation')
  "call add(g:spacevim_plugin_groups, 'misc')

  call add(g:spacevim_plugin_groups, 'core')
  call add(g:spacevim_plugin_groups, 'unite')
" call add(g:spacevim_plugin_groups, 'github')
  if has('python3')
    call add(g:spacevim_plugin_groups, 'denite')
  endif
" call add(g:spacevim_plugin_groups, 'ctrlp')
  call add(g:spacevim_plugin_groups, 'autocomplete')
  if ! has('nvim')
    call add(g:spacevim_plugin_groups, 'vim')
  else
    call add(g:spacevim_plugin_groups, 'nvim')
  endif
  if OSX()
    call add(g:spacevim_plugin_groups, 'osx')
  endif
  if WINDOWS()
    call add(g:spacevim_plugin_groups, 'windows')
  endif
  if LINUX()
    call add(g:spacevim_plugin_groups, 'linux')
  endif
endfunction

if g:spacevim_snippet_engine ==# 'neosnippet'
  function! s:SpaceVimmappingtabi_tab() abort
    if getline('.')[col('.')-2] ==# '{'&& pumvisible()
      return "\<C-n>"
    endif
    if index(g:spacevim_plugin_groups, 'autocomplete') != -1
      if neosnippet#expandable() && getline('.')[col('.')-2] ==# '(' && !pumvisible()
        return "\<Plug>(neosnippet_expand)"
      elseif neosnippet#jumpable()
            \ && getline('.')[col('.')-2] ==# '(' && !pumvisible() 
            \ && !neosnippet#expandable()
        return "\<plug>(neosnippet_jump)"
      elseif neosnippet#expandable_or_jumpable() && getline('.')[col('.')-2] !=#'('
        return "\<plug>(neosnippet_expand_or_jump)"
      elseif pumvisible()
        return "\<C-n>"
      else
        return "\<tab>"
      endif
    elseif pumvisible()
      return "\<C-n>"
    else
      return "\<tab>"
    endif
  endfunction
elseif g:spacevim_snippet_engine ==# 'ultisnips'
  function! s:SpaceVimmappingtabi_tab() abort
    return "\<tab>"
  endfunction
endif

function! SpaceVim#default#SetMappings() abort

  "mapping
  " Yank from the cursor to the end of the line, to be consistent with C and D.
  nnoremap Y y$

  imap <silent><expr><TAB> <SID>SpaceVimmappingtabi_tab()
  imap <expr><S-TAB> pumvisible() ? "\<C-p>" : ""
  imap <silent><expr><S-TAB> SpaceVim#mapping#shift_tab()
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
  imap <silent><expr><CR> SpaceVim#mapping#enter#i_enter()
  inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
  inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
  inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
  inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
  smap <expr><S-TAB> pumvisible() ? "\<C-p>" : ""
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

  "]<End> or ]<Home> move current line to the end or the begin of current buffer
  nnoremap <silent>]<End> ddGp``
  nnoremap <silent>]<Home> ddggP``
  vnoremap <silent>]<End> dGp``
  vnoremap <silent>]<Home> dggP``


  "Ctrl+Shift+Up/Down to move up and down
  nnoremap <silent><C-S-Down> :m .+1<CR>==
  nnoremap <silent><C-S-Up> :m .-2<CR>==
  inoremap <silent><C-S-Down> <Esc>:m .+1<CR>==gi
  inoremap <silent><C-S-Up> <Esc>:m .-2<CR>==gi
  vnoremap <silent><C-S-Down> :m '>+1<CR>gv=gv
  vnoremap <silent><C-S-Up> :m '<-2<CR>gv=gv
  " download gvimfullscreen.dll from github, copy gvimfullscreen.dll to
  " the directory that has gvim.exe
  "nnoremap <F11> :call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<cr>

  " Start new line
  " inoremap <S-Return> <C-o>o

  " Improve scroll, credits: https://github.com/Shougo
  nnoremap <expr> zz (winline() == (winheight(0)+1) / 2) ?
        \ 'zt' : (winline() == 1) ? 'zb' : 'zz'
  noremap <expr> <C-f> max([winheight(0) - 2, 1])
        \ ."\<C-d>".(line('w$') >= line('$') ? "L" : "H")
  noremap <expr> <C-b> max([winheight(0) - 2, 1])
        \ ."\<C-u>".(line('w0') <= 1 ? "H" : "L")
  noremap <expr> <C-e> (line("w$") >= line('$') ? "j" : "3\<C-e>")
  noremap <expr> <C-y> (line("w0") <= 1         ? "k" : "3\<C-y>")

  " Select blocks after indenting
  xnoremap < <gv
  xnoremap > >gv|

  " Use tab for indenting in visual mode
  xnoremap <Tab> >gv|
  xnoremap <S-Tab> <gv
  nnoremap > >>_
  nnoremap < <<_

  " smart up and down
  nnoremap <silent><Down> gj
  nnoremap <silent><Up> gk

  " Select last paste
  nnoremap <silent><expr> gp '`['.strpart(getregtype(), 0, 1).'`]'

  " Use Q format lines
  map Q gq

  " Navigate window
  nnoremap <silent><C-q> <C-w>
  nnoremap <silent><C-x> <C-w>x

  " Navigation in command line
  cnoremap <C-a> <Home>
  cnoremap <C-b> <Left>
  cnoremap <C-f> <Right>


  " Fast saving
  nnoremap <C-s> :<C-u>w<CR>
  vnoremap <C-s> :<C-u>w<CR>
  cnoremap <C-s> <C-u>w<CR>

  " Tabs
  nnoremap <silent>g0 :<C-u>tabfirst<CR>
  nnoremap <silent>g$ :<C-u>tablast<CR>
  nnoremap <silent>gr :<C-u>tabprevious<CR>

  " Remove spaces at the end of lines
  nnoremap <silent> ,<Space> :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>

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

endfunction

function! SpaceVim#default#UseSimpleMode() abort

endfunction

" vim:set et sw=2:
