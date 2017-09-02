if g:spacevim_nvim
  MP 'Shougo/deoplete.nvim'
  MP 'roxma/nvim-completion-manager'
  MP 'roxma/nvim-cm-racer'
elseif g:spacevim_vim8
  MP 'prabirshrestha/async.vim' MP 'prabirshrestha/asyncomplete.vim'
  MP 'prabirshrestha/asyncomplete-buffer.vim'
  MP 'prabirshrestha/asyncomplete-gocode.vim'
  MP 'keremc/asyncomplete-racer.vim'
else
  MP 'Shougo/neocomplete.vim'
endif

MP 'Shougo/neocomplcache.vim'
MP 'Shougo/neco-syntax'
MP 'Raimondi/delimitMate'
MP 'Shougo/neopairs.vim'
MP 'Shougo/neoinclude.vim'
