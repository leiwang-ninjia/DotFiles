function! SpaceVim#layers#unite#plugins() abort
    let plugins = [
                \ ['Shougo/unite.vim',{ 'merged' : 0 , 'loadconf' : 1}],
                \ ['Shougo/neoyank.vim'],
                \ ['Shougo/neomru.vim'],
                \ ['Shougo/unite-outline'],
                \ ['hewes/unite-gtags'],
                \ ['tsukkee/unite-tag'],
                \ ['Shougo/unite-help'],
                \ ['mileszs/ack.vim',{'on_cmd' : 'Ack'}],
                \ ['albfan/ag.vim',{'on_cmd' : 'Ag'}],
                \ ['dyng/ctrlsf.vim',{'on_cmd' : 'CtrlSF'}],
                \ ['Shougo/unite-session'],
                \ ['osyo-manga/unite-quickfix'],
                \ ['lambdalisue/unite-grep-vcs', {
                \ 'autoload': {
                \    'unite_sources': ['grep/git', 'grep/hg'],
                \ }}],
                \ ]

    if g:spacevim_filemanager ==# 'vimfiler'
        call add(plugins, ['Shougo/vimfiler.vim',{'merged' : 0}])
    endif
    return plugins
endfunction

function! SpaceVim#layers#unite#config() abort
    """ config CtrlSF {{{
    nmap <silent><leader>sn <Plug>CtrlSFCwordExec
    nmap <leader>sf <Plug>CtrlSFPrompt
    vmap <leader>sf <Plug>CtrlSFVwordPath
    vmap <leader>sF <Plug>CtrlSFVwordExec
    nmap <leader>sp <Plug>CtrlSFPwordPath
    nnoremap <leader>so :CtrlSFOpen<CR>
    nnoremap <leader>st :CtrlSFToggle<CR>
    inoremap <leader>st <Esc>:CtrlSFToggle<CR>
    """}}}

    """ {{{
    let g:vimfiler_as_default_explorer = get(g:, 'vimfiler_as_default_explorer', 1)
    let g:vimfiler_restore_alternate_file = get(g:, 'vimfiler_restore_alternate_file', 1)
    let g:vimfiler_tree_indentation = get(g:, 'vimfiler_tree_indentation', 1)
    let g:vimfiler_tree_leaf_icon = get(g:, 'vimfiler_tree_leaf_icon', '')
    let g:vimfiler_tree_opened_icon = get(g:, 'vimfiler_tree_opened_icon', '▼')
    let g:vimfiler_tree_closed_icon = get(g:, 'vimfiler_tree_closed_icon', '▷')
    let g:vimfiler_file_icon = get(g:, 'vimfiler_file_icon', '')
    let g:vimfiler_readonly_file_icon = get(g:, 'vimfiler_readonly_file_icon', '*')
    let g:vimfiler_marked_file_icon = get(g:, 'vimfiler_marked_file_icon', '√')
    "let g:vimfiler_preview_action = 'auto_preview'
    let g:vimfiler_ignore_pattern = [
                \ '^\.git$',
                \ '^\.DS_Store$',
                \ '^\.init\.vim-rplugin\~$',
                \ '^\.netrwhist$',
                \ '\.class$'
                \]

    if has('mac')
        let g:vimfiler_quick_look_command =
                    \ '/Applications//Sublime\ Text.app/Contents/MacOS/Sublime\ Text'
    else
        let g:vimfiler_quick_look_command = 'gloobus-preview'
    endif
    function! s:setcolum() abort
        if g:spacevim_enable_vimfiler_filetypeicon && !g:spacevim_enable_vimfiler_gitstatus
            return 'filetypeicon'
        elseif !g:spacevim_enable_vimfiler_filetypeicon && g:spacevim_enable_vimfiler_gitstatus
            return 'gitstatus'
        elseif g:spacevim_enable_vimfiler_filetypeicon && g:spacevim_enable_vimfiler_gitstatus
            return 'filetypeicon:gitstatus'
        else
            return ''
        endif
    endfunction
    "try
    call vimfiler#custom#profile('default', 'context', {
                \ 'explorer' : 1,
                \ 'winwidth' : g:spacevim_sidebar_width,
                \ 'winminwidth' : 30,
                \ 'toggle' : 1,
                \ 'auto_expand': 1,
                \ 'direction' : 'rightbelow',
                \ 'explorer_columns' : s:setcolum(),
                \ 'parent': 0,
                \ 'status' : 1,
                \ 'safe' : 0,
                \ 'split' : 1,
                \ 'hidden': 1,
                \ 'no_quit' : 1,
                \ 'force_hide' : 0,
                \ })

    "catch
    "endtry
    augroup vfinit
        au!
        autocmd FileType vimfiler call s:vimfilerinit()
        autocmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') |
                    \ q | endif
    augroup END
    function! s:vimfilerinit()
        set nonumber
        set norelativenumber

        silent! nunmap <buffer> <Space>
        silent! nunmap <buffer> <C-l>
        silent! nunmap <buffer> <C-j>
        silent! nunmap <buffer> E
        silent! nunmap <buffer> gr
        silent! nunmap <buffer> gf
        silent! nunmap <buffer> -
        silent! nunmap <buffer> s

        nnoremap <silent><buffer> gr  :<C-u>Denite grep:<C-R>=<SID>selected()<CR> -buffer-name=grep<CR>
        nnoremap <silent><buffer> gf  :<C-u>Denite file_rec:<C-R>=<SID>selected()<CR><CR>
        nnoremap <silent><buffer> gd  :<C-u>call <SID>change_vim_current_dir()<CR>
        nnoremap <silent><buffer><expr> sg  vimfiler#do_action('vsplit')
        nnoremap <silent><buffer><expr> sv  vimfiler#do_action('split')
        nnoremap <silent><buffer><expr> st  vimfiler#do_action('tabswitch')
        nmap <buffer> gx     <Plug>(vimfiler_execute_vimfiler_associated)
        nmap <buffer> '      <Plug>(vimfiler_toggle_mark_current_line)
        nmap <buffer> v      <Plug>(vimfiler_quick_look)
        nmap <buffer> p      <Plug>(vimfiler_preview_file)
        nmap <buffer> V      <Plug>(vimfiler_clear_mark_all_lines)
        nmap <buffer> i      <Plug>(vimfiler_switch_to_history_directory)
        nmap <buffer> <Tab>  <Plug>(vimfiler_switch_to_other_window)
        nmap <buffer> <C-r>  <Plug>(vimfiler_redraw_screen)
    endf
    noremap <silent> <F3> :call <SID>OpenVimfiler()<CR>

    function! s:OpenVimfiler() abort
        if bufnr('vimfiler') == -1
            VimFiler
            AirlineRefresh
            wincmd p
            if &filetype !=# 'startify'
                IndentLinesToggle
                IndentLinesToggle
            endif
            wincmd p
        else
            VimFiler
            AirlineRefresh
        endif
    endfunction

    """}}}

    "nnoremap <leader>gd :execute 'Unite  -auto-preview -start-insert -no-split gtags/def:'.expand('<cword>')<CR>
    "nnoremap <leader>gc :execute 'Unite  -auto-preview -start-insert -no-split gtags/context'<CR>
    nnoremap <leader>gr :execute 'Unite  -auto-preview -start-insert -no-split gtags/ref'<CR>
    nnoremap <leader>gg :execute 'Unite  -auto-preview -start-insert -no-split gtags/grep'<CR>
    "nnoremap <leader>gp :execute 'Unite  -auto-preview -start-insert -no-split gtags/completion'<CR>
    vnoremap <leader>gd <ESC>:execute 'Unite -auto-preview -start-insert -no-split gtags/def:'.GetVisualSelection()<CR>
    let g:unite_source_gtags_project_config = get(g:, 'unite_source_gtags_project_config', {
                \ '_':                   { 'treelize': 0 }
                \ })
endfunction
