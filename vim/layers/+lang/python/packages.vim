MP 'tmhedberg/SimpylFold',     { 'for': 'python' }
MP 'python-mode/python-mode',  { 'for': 'python' }
if has('nvim')
	MP 'zchee/deoplete-jedi',  { 'for' : 'python'}
else
	MP 'davidhalter/jedi-vim', { 'for' : 'python'}
endif
