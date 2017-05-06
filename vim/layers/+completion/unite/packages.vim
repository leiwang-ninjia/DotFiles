" temporarily disabled
" MP 'Shougo/denite.nvim'

MP 'Shougo/unite.vim'
MP 'Shougo/neomru.vim'
MP 'Shougo/neoyank.vim'
MP 'Shougo/unite-outline'
MP 'hewes/unite-gtags'
MP 'tsukkee/unite-tag'
MP 'mileszs/ack.vim'
MP 'albfan/ag.vim'
MP 'dyng/ctrlsf.vim'
MP 'Shougo/unite-session'
MP 'osyo-manga/unite-quickfix' 
MP 'lambdalisue/unite-grep-vcs'

if funcs#LayerLoaded('tmux')
   MP 'ctrlpvim/ctrlp.vim'
   MP 'FelikZ/ctrlp-py-matcher'
else
   MP 'ctrlpvim/ctrlp.vim',      { 'on': ['CtrlP', 'CtrlPMRU'] }
   MP 'FelikZ/ctrlp-py-matcher', { 'on': ['CtrlP', 'CtrlPMRU'] }
endif
