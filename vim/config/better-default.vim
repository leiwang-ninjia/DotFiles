scriptencoding utf-8

  " basic vim settiing {
    set nocompatible        " Must be first line
  " }
   
  " General {
    " filetype plugin indent on   " Automatically detect file types.
    " syntax on                   " Syntax highlighting
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    set hidden                          " Allow buffer switching without saving
    set virtualedit=onemore             " Allow for cursor beyond last character
    set iskeyword-=.                    " '.' is an end of word designator
    set iskeyword-=#                    " '#' is an end of word designator
    set iskeyword-=-                    " '-' is an end of word designator
    if has('termguicolors')
      let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
      let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
      set termguicolors
    endif
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
  " }

" Vim UI {
  set tabpagemax=15               " Only show 15 tabs
  set showmode                    " Display the current mode
  set nocursorline                  " Highlight current line
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
    "if !exists('g:override_spf13_bundles')
    "  set statusline+=%{fugitive#statusline()} " Git Hotness
    "endif
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
  set smartcase                   " Case sensitive when uc present
  set wildmenu                    " Show list instead of just completing
  set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
  set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
  set scrolljump=5                " Lines to scroll when cursor leaves screen
  set scrolloff=3                 " Minimum lines to keep above and below cursor
  "set foldenable                  " Auto fold code
  set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
  set fillchars+=vert:│
"}

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

  "set autoread " autoread

  " backup
  "set nobackup
  "set noundofile

  " no fold enable
  " set nofoldenable
  " set nowritebackup
  "menuone: show the pupmenu when only one match
  " disable preview scratch window,
  " set completeopt=menu,menuone,longest
  " h: 'complete'
  " set complete=.,w,b,u,t
  " limit completion menu height
  set pumheight=15
  "set wildignorecase
  "set ttimeout
  "set ttimeoutlen=50
  "set background=dark
  "set nostartofline

  if exists('&colorcolumn')
    set colorcolumn=80
  endif
