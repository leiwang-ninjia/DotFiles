function! SpaceVim#layers#lang#vim#plugins() abort
    let plugins = [
                \ ['syngan/vim-vimlint',                     { 'on_ft' : 'vim'}],
                \ ['ynkdir/vim-vimlparser',                  { 'on_ft' : 'vim'}],
                \ ['todesking/vint-syntastic',               { 'on_ft' : 'vim'}],
                \ ]
    call add(plugins,['tweekmonster/exception.vim'])
    call add(plugins,['mhinz/vim-lookup'])
    call add(plugins,['Shougo/neco-vim',              { 'on_i' : 1 }])
    call add(plugins,['tweekmonster/helpful.vim',      {'on_cmd': 'HelpfulVersion'}])
    return plugins
endfunction

function! SpaceVim#layers#lang#vim#config() abort
    if !exists('g:necovim#complete_functions')
        let g:necovim#complete_functions = {}
    endif
    let g:necovim#complete_functions.Ref =
                \ 'ref#complete'
    call SpaceVim#mapping#gd#add('vim','lookup#lookup')
endfunction
