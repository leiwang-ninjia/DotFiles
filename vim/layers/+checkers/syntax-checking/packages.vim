if g:spacevim_vim8 || g:spacevim_nvim
    MP 'w0rp/ale', { 'on': ['ALEEnable', 'ALEToggle'] }
	MP 'neomake/neomake'
else
    MP 'scrooloose/syntastic',     { 'on': 'SyntasticCheck' }
endif
