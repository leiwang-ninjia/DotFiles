" tabular {
  nmap <Leader>a& :Tabularize /&<CR>
  vmap <Leader>a& :Tabularize /&<CR>
  nmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
  vmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
  nmap <Leader>a=> :Tabularize /=><CR>
  vmap <Leader>a=> :Tabularize /=><CR>
  nmap <Leader>a: :Tabularize /:<CR>
  vmap <Leader>a: :Tabularize /:<CR>
  nmap <Leader>a:: :Tabularize /:\zs<CR>
  vmap <Leader>a:: :Tabularize /:\zs<CR>
  nmap <Leader>a, :Tabularize /,<CR>
  vmap <Leader>a, :Tabularize /,<CR>
  nmap <Leader>a,, :Tabularize /,\zs<CR>
  vmap <Leader>a,, :Tabularize /,\zs<CR>
  nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
  vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
" }

" vim-easy-align {
  " Start interactive EasyAlign in visual mode (e.g. vipxa)
  xmap <Leader>xa <Plug>(EasyAlign)
	let g:easy_align_delimiters = {
				\ '>': { 'pattern': '>>\|=>\|>' },
				\ '\': { 'pattern': '\\' },
				\ '/': { 'pattern': '//\+\|/\*\|\*/', 'delimiter_align': 'l', 'ignore_groups': ['!Comment'] },
				\ ']': {
				\     'pattern':       '\]\zs',
				\     'left_margin':   0,
				\     'right_margin':  1,
				\     'stick_to_left': 0
				\   },
				\ ')': {
				\     'pattern':       ')\zs',
				\     'left_margin':   0,
				\     'right_margin':  1,
				\     'stick_to_left': 0
				\   },
				\ 'f': {
				\     'pattern': ' \(\S\+(\)\@=',
				\     'left_margin': 0,
				\     'right_margin': 0
				\   },
				\ 'd': {
				\     'pattern': ' \ze\S\+\s*[;=]',
				\     'left_margin': 0,
				\     'right_margin': 0
				\   }
				\ }
    " Start interactive EasyAlign in visual mode (e.g. vipxa)
    xmap <Leader>xa <Plug>(EasyAlign)

  " Start interactive EasyAlign for a motion/text object (e.g. xaip)
  nmap <Leader>xa <Plug>(EasyAlign)
" }
