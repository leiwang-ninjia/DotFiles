function! SpaceVim#layers#edit#plugins() abort
    let plugins = [
                \ ['tpope/vim-surround'],
                \ ['tpope/vim-repeat'],
                \ ['tpope/vim-commentary'],
                \ ['junegunn/vim-emoji'],
                \ ['terryma/vim-multiple-cursors'],
                \ ['terryma/vim-expand-region'],
                \ ['junegunn/vim-easy-align'],
                \ ['scrooloose/nerdcommenter'],
                \ ['mattn/emmet-vim',                        { 'on_cmd' : 'EmmetInstall'}],
                \ ['easymotion/vim-easymotion',{'on_map' : '<Plug>(easymotion-prefix)', 'on_func' : 'EasyMotion#go'}],
                \ ['editorconfig/editorconfig-vim', { 'on_cmd' : 'EditorConfigReload'}],
                \ ]
    return plugins
endfunction

function! SpaceVim#layers#edit#config() abort
    let g:multi_cursor_next_key='<C-j>'
    let g:multi_cursor_prev_key='<C-k>'
    let g:multi_cursor_skip_key='<C-x>'
    let g:multi_cursor_quit_key='<Esc>'
    let g:user_emmet_install_global = 0
    let g:user_emmet_leader_key='<C-e>'
    let g:user_emmet_mode='a'
    let g:user_emmet_settings = {
                \  'jsp' : {
                \      'extends' : 'html',
                \  },
                \}
    map <Leader>j <Plug>(easymotion-prefix)
	xmap v <Plug>(expand_region_expand)
	xmap V <Plug>(expand_region_shrink)
endfunction
