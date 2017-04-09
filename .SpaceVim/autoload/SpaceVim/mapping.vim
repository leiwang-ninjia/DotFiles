scriptencoding utf-8
let g:unite_source_menu_menus =
      \ get(g:,'unite_source_menu_menus',{})
let g:unite_source_menu_menus.CustomKeyMaps = {'description':
      \ 'Custom mapped keyboard shortcuts                   [unite]<SPACE>'}
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates =
      \ get(g:unite_source_menu_menus.CustomKeyMaps,'command_candidates', [])

function! SpaceVim#mapping#_def(type,key,value,desc,...) abort
  exec a:type . ' ' . a:key . ' ' . a:value
  let description = '➤ '
        \. a:desc
        \. repeat(' ', 80 - len(a:desc) - len(a:key))
        \. a:key
  let cmd = len(a:000) > 0 ? a:000[0] : a:value
  call add(g:unite_source_menu_menus.CustomKeyMaps.command_candidates, [description,cmd])
endfunction

" a:1 unite desc
" a:2 unite cmd
" a:3 guide desc
" example  call SpaceVim#mapping#def('nnoremap <silent>', 'gf', ':call zvim#gf()<CR>', 'Jump to a file under cursor', '')
function! SpaceVim#mapping#def(type, key, value, ...) abort
  let feedkeys_mode = 'm'
  let map = split(a:type)[0]
  if map =~# 'nore'
    let feedkeys_mode = 'n'
  endif
  " TODO parse lhs and rhs, return list of key
  "let lhs = a:key
  "let rhs = a:value
  let gexe = a:value
  if a:value =~? '^<plug>'
    let gexe = '\' . a:value
  elseif a:value =~? ':.\+<cr>$'
    let gexe = substitute(gexe, '<cr>', "\<cr>", 'g')
    let gexe = substitute(gexe, '<CR>', "\<CR>", 'g')
    let gexe = substitute(gexe, '<Esc>', "\<Esc>", 'g')
  else
  endif
  exec a:type . ' ' . a:key . ' ' . a:value
  if a:0 > 0
    let desc = a:1
    let description = '➤ '
          \ . desc
          \ . repeat(' ', 80 - len(desc) - len(a:key))
          \ . a:key
    let cmd = a:0 == 2 ? a:2 : a:value
    call add(g:unite_source_menu_menus.CustomKeyMaps.command_candidates, [description,cmd])
    if a:0 == 3
      " enable guide
      if a:key =~? '^<leader>'
        if len(a:key) > 9
          let group = a:key[8:8]
          if !has_key(g:_spacevim_mappings, group)
            let g:_spacevim_mappings[group] = {'name': 'new group'}
          endif
          call extend(g:_spacevim_mappings[group], {
                \ a:key[9:] : ['call feedkeys("' . gexe . '", "'
                \ . feedkeys_mode . '")', a:3]
                \ })
        elseif len(a:key) == 9
          call extend(g:_spacevim_mappings, {
                \ a:key[8:] : ['call feedkeys("' . gexe . '", "'
                \ . feedkeys_mode . '")', a:3]
                \ })

        endif
      endif
    endif
  endif
endfunction

function! SpaceVim#mapping#shift_tab() abort
  return pumvisible() ? "\<C-p>" : "\<Plug>delimitMateS-Tab"
endfunction

function! SpaceVim#mapping#tab() abort
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

function! SpaceVim#mapping#enter() abort
  if pumvisible()
    if getline('.')[col('.') - 2]==# '{'
      return "\<Enter>"
    elseif g:spacevim_autocomplete_method ==# 'neocomplete'||g:spacevim_autocomplete_method ==# 'deoplete'
      return "\<C-y>"
    else
      return "\<esc>a"
    endif
  elseif getline('.')[col('.') - 2]==#'{'&&getline('.')[col('.')-1]==#'}'
    return "\<Enter>\<esc>ko"
  else
    return "\<Enter>"
  endif
endfunction

function! SpaceVim#mapping#close_term_buffer(...) abort
  let buffers = get(g:, '_spacevim_list_buffers', [])
  let abuf = str2nr(g:_spacevim_termclose_abuf)
  let index = index(buffers, abuf)
  if index != -1
    if index == 0
      if len(buffers) > 1
        exe 'b' . buffers[1]
        exe 'bd!' . abuf
      else
        exe 'bd! ' . abuf
      endif
    elseif index > 0
      if index + 1 == len(buffers)
        exe 'b' . buffers[index - 1]
        exe 'bd!' . abuf
      else
        exe 'b' . buffers[index + 1]
        exe 'bd!' . abuf
      endif
    endif
  endif

endfunction

" vim:set et sw=2 cc=80:
