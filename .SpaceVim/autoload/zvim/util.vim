scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim
let g:unite_source_menu_menus =
            \ get(g:,'unite_source_menu_menus',{})
let g:unite_source_menu_menus.CustomKeyMaps = {'description':
            \ 'Custom mapped keyboard shortcuts                   [unite]<SPACE>'}
let g:unite_source_menu_menus.CustomKeyMaps.command_candidates =
            \ get(g:unite_source_menu_menus.CustomKeyMaps,'command_candidates', [])

fu! zvim#util#source_rc(file) abort
    if filereadable(g:Config_Main_Home. '/' . a:file)
        execute 'source ' . g:Config_Main_Home  . '/' . a:file
    endif
endf

let &cpo = s:save_cpo
unlet s:save_cpo
