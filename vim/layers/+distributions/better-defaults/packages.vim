" if g:MAC
    " Plug 'ybian/smartim'
" endif

MP 'tpope/vim-rsi'

MP 'mhinz/vim-startify'
augroup spacevimStart
  autocmd!
  autocmd VimEnter *
              \   if !argc()
              \|    call plug#load('vim-startify')
              \|    silent! Startify
              \|  endif
augroup END

MP 'tpope/vim-surround'
MP 'dominikduda/vim_current_word'

MP 'itchyny/vim-cursorword'

MP 'terryma/vim-expand-region'

MP 'junegunn/vim-easy-align'

MP 'tpope/vim-repeat'

MP 'tpope/vim-commentary', { 'on': '<Plug>Commentary' }

MP 'Shougo/vimproc.vim'

MP 'nvim-lua/popup.nvim'
MP 'nvim-lua/plenary.nvim'
MP 'nvim-telescope/telescope.nvim'
MP 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Bug here.
" MP 'kana/vim-operator-user',         { 'on': '<Plug>(operator-flashy)' }
" MP 'haya14busa/vim-operator-flashy', { 'on': '<Plug>(operator-flashy)' }

"MP 'ntpeters/vim-better-whitespace', { 'on': 'StripWhitespace' }

if !g:spacevim_nvim
  MP 'haya14busa/incsearch.vim',       { 'on': [
              \ '<Plug>(incsearch-forward)',
              \ '<Plug>(incsearch-backward)',
              \ '<Plug>(incsearch-stay)' ]
              \ }
  MP 'haya14busa/incsearch-fuzzy.vim',  { 'on': [
              \ '<Plug>(incsearch-fuzzy-/)',
              \ '<Plug>(incsearch-fuzzy-?)',
              \ '<Plug>(incsearch-fuzzy-stay)' ]
              \ }
endif
