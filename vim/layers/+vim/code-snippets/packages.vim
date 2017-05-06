" Refer to https://github.com/junegunn/vim-plug/wiki/faq
" Load on nothing
MP 'SirVer/ultisnips', { 'on': [] } | MP 'honza/vim-snippets', { 'on': [] }
MP 'Shougo/neosnippet-snippets'
MP 'honza/vim-snippets'
MP 'Shougo/neosnippet-snippets'
MP 'Shougo/neosnippet.vim'

augroup load_snips
    autocmd!
    autocmd InsertEnter * call plug#load('ultisnips', 'vim-snippets')
                \| autocmd! load_snips
augroup END
