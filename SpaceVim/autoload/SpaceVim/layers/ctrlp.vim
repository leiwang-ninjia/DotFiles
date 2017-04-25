function! SpaceVim#layers#ctrlp#plugins() abort
	let plugins =[['ctrlpvim/ctrlp.vim']]
    "let plugins = [
                "\ ['ctrlpvim/ctrlp.vim'],
                "\ ['voronkovich/ctrlp-nerdtree.vim', { 'on_cmd' : 'CtrlPNerdTree'}],
                "\ ['h14i/vim-ctrlp-buftab',          { 'on_cmd' : 'CtrlPBufTab'}],
                "\ ['vim-scripts/ctrlp-cmdpalette',   { 'on_cmd' : 'CtrlPCmdPalette'}],
                "\ ['mattn/ctrlp-windowselector',     { 'on_cmd' : 'CtrlPWindowSelector'}],
                "\ ['the9ball/ctrlp-gtags',           { 'on_cmd' : ['CtrlPGtagsX','CtrlPGtagsF','CtrlPGtagsR']}],
                "\ ['thiderman/ctrlp-project',        { 'on_cmd' : 'CtrlPProject'}],
                "\ ['mattn/ctrlp-google',             { 'on_cmd' : 'CtrlPGoogle'}],
                "\ ['ompugao/ctrlp-history',          { 'on_cmd' : ['CtrlPCmdHistory','CtrlPSearchHistory']}],
                "\ ['pielgrzym/ctrlp-sessions',       { 'on_cmd' : ['CtrlPSessions','MkS']}],
                "\ ['tacahiroy/ctrlp-funky',          { 'on_cmd' : 'CtrlPFunky'}],
                "\ ['mattn/ctrlp-launcher',           { 'on_cmd' : 'CtrlPLauncher'}],
                "\ ['sgur/ctrlp-extensions.vim',      { 'on_cmd' : ['CtrlPCmdline','CtrlPMenu','CtrlPYankring']}],
                "\ ['FelikZ/ctrlp-py-matcher'],
                "\ ['lambdalisue/vim-gista-ctrlp',    { 'on_cmd' : 'CtrlPGista'}],
                "\ ['elentok/ctrlp-objects.vim',      { 'on_cmd' : [
                "\'CtrlPModels',
                "\'CtrlPViews',
                "\'CtrlPControllers',
                "\'CtrlPTemplates',
                "\'CtrlPPresenters']}],
                "\ ]
    "if !has('nvim')
        "call add(plugins, ['wsdjeg/ctrlp-unity3d-docs',  { 'on_cmd' : 'CtrlPUnity3DDocs'}])
    "endif
    return plugins
endfunction
function! SpaceVim#layers#ctrlp#plugins() abort
    let g:ctrlp_map = get(g:,'ctrlp_map', '<c-p>')
    let g:ctrlp_cmd = get(g:, 'ctrlp_cmd', 'CtrlP')
    let g:ctrlp_working_path_mode = get(g:, 'ctrlp_working_path_mode', 'ra')
    let g:ctrlp_root_markers = get(g:, 'ctrlp_root_markers', 'pom.xml')
    let g:ctrlp_match_window = get(g:, 'ctrlp_match_window', 'bottom,order:btt,min:1,max:15,results:15')
    let g:ctrlp_show_hidden = get(g:, 'ctrlp_show_hidden', 1)
    "for caching
    let g:ctrlp_use_caching = get(g:, 'ctrlp_use_caching', 500)
    let g:ctrlp_clear_cache_on_exit = get(g:, 'ctrlp_clear_cache_on_exit', 1)
    let g:ctrlp_cache_dir = get(g:, 'ctrlp_cache_dir', $HOME.'/.cache/ctrlp')
    "let g:ctrlp_map = ',,'
    "let g:ctrlp_open_multiple_files = 'v'
    "if you have install ag, the g:ctrlp_custom_ignore will not work
    let g:ctrlp_custom_ignore = get(g:, 'ctrlp_custom_ignore', {
                \ 'dir':  '\v[\/]\.(git|hg|svn)$|target|node_modules|te?mp$|logs?$|public$|dist$',
                \ 'file': '\v\.(exe|so|dll|ttf|png|gif|jpe?g|bpm)$|\-rplugin\~',
                \ 'link': 'some_bad_symbolic_links',
                \ })
    if executable('rg') && !exists('g:ctrlp_user_command')
        let g:ctrlp_user_command = 'rg %s --no-ignore --hidden --files -g "" '
                    \ . join(<SID>Generate_ignore(g:spacevim_wildignore,'rg'))
    elseif executable('ag') && !exists('g:ctrlp_user_command')
        let g:ctrlp_user_command = 'ag %s --hidden -i  -g "" ' . join(<SID>Generate_ignore(g:spacevim_wildignore,'ag'))
    endif
    if !exists('g:ctrlp_match_func') && (has('python') || has('python3'))
        let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch'  }
    endif
    "nnoremap <Leader>kk :CtrlPMixed<Cr>
    " comment for ctrlp-funky {{{
    nnoremap <Leader>fu :CtrlPFunky<Cr>
    " narrow the list down with a word under cursor
    nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
    let g:ctrlp_funky_syntax_highlight = get(g:, 'ctrlp_funky_syntax_highlight', 1)
    " }}}
    "for ctrlp_nerdtree {{{
    let g:ctrlp_nerdtree_show_hidden = get(g:, 'ctrlp_nerdtree_show_hidden', 1)
    "}}}
    "for ctrlp_sessions{{{
    let g:ctrlp_extensions = ['funky', 'sessions' , 'k' , 'tag', 'mixed', 'quickfix', 'undo', 'line', 'changes', 'cmdline', 'menu']
    "}}}
    "for k.vim {{{
    nnoremap <silent> <leader>qe :CtrlPK<CR>
    "}}}
    " for ctrlp-launcher {{{
    nnoremap <Leader>pl :<c-u>CtrlPLauncher<cr>
    "}}}
    ""for ctrlp-cmatcher {{{
    "let g:ctrlp_max_files = 0
    "let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
    ""}}}

    augroup Fix_command_in_help_buffer
        au!
        autocmd FileType help exec 'nnoremap <buffer><silent><c-p> :<c-u>CtrlP ' . getcwd() .'<cr>'
        au FileType help exec "nnoremap <silent><buffer> q :q<CR>"
    augroup END

    fu! s:Generate_ignore(ignore,tool) abort
        let ignore = []
        if a:tool ==# 'ag'
            for ig in split(a:ignore,',')
                call add(ignore, '--ignore')
                call add(ignore, ig )
            endfor
        elseif a:tool ==# 'rg'
            for ig in split(a:ignore,',')
                call add(ignore, '-g')
                call add(ignore, '!' . ig)
            endfor
        endif
        return ignore
    endf
endfunction

