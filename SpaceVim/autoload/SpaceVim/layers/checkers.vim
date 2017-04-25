""
" @section checkers, layer-checkers
" @parentsection layers
" SpaceVim uses neomake as default syntax checker.

function! SpaceVim#layers#checkers#plugins() abort
    let plugins = []

    if g:spacevim_enable_neomake
        call add(plugins, ['neomake/neomake', {'merged' : 0, 'loadconf' : 1 }])
    else
        call add(plugins, ['wsdjeg/syntastic', {'on_event': 'WinEnter', 'loadconf' : 1, 'merged' : 0}])
    endif

    return plugins
endfunction
function! SpaceVim#layers#checkers#config() abort
    " 1 open list and move cursor 2 open list without move cursor
    let g:neomake_open_list = get(g:, 'neomake_open_list', 2)
    let g:neomake_verbose = get(g:, 'neomake_verbose', 0)
    let g:neomake_java_javac_delete_output = get(g:, 'neomake_java_javac_delete_output', 0)
    let g:neomake_error_sign = get(g:, 'neomake_error_sign', {
                \ 'text': get(g:, 'spacevim_error_symbol', '✖'),
                \ 'texthl': (g:spacevim_colorscheme ==# 'gruvbox' ? 'GruvboxRedSign' : 'error'),
                \ })
    let g:neomake_warning_sign = get(g:, 'neomake_warning_sign', {
                \ 'text': get(g:,'spacevim_warning_symbol', '➤'),
                \ 'texthl': (g:spacevim_colorscheme ==# 'gruvbox' ? 'GruvboxYellowSign' : 'todo'),
                \ })
    if get(g:, 'spacevim_lint_on_save', 0)
        augroup Neomake_on_save
            au!
            autocmd! BufWritePost * Neomake
        augroup END
    endif
    if empty(maparg('<leader>ck', '',0,1))
        nnoremap <silent> <Leader>ck :Neomake<CR>
    endif

    if get(g:, 'spacevim_lint_on_the_fly', 0)
        let g:neomake_tempfile_enabled = 1
        let g:neomake_open_list = 0
        augroup Neomake_on_the_fly
            au!
            autocmd! TextChangedI * Neomake
        augroup END
    endif
endfunction
