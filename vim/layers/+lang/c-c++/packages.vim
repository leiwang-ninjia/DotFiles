MP 'rhysd/vim-clang-format',           { 'for': [ 'c', 'cpp' ] }
MP 'octol/vim-cpp-enhanced-highlight', { 'for': [ 'c', 'cpp' ] }

if has('nvim')
	MP 'tweekmonster/deoplete-clang2'
else
	MP 'Rip-Rip/clang_complete'
endif
MP 'lyuts/vim-rtags'
