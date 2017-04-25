scriptencoding utf-8
function! SpaceVim#layers#ui#plugins() abort
    return [
                \ ['Yggdroot/indentLine'],
                \ ['mhinz/vim-signify'],
                \ ['majutsushi/tagbar'],
                \ ['vim-airline/vim-airline',                { 'merged' : 0}],
                \ ['vim-airline/vim-airline-themes',         { 'merged' : 0}],
                \ ['mhinz/vim-startify'],
                \ ]
endfunction

function! SpaceVim#layers#ui#config() abort
    let g:startify_custom_header = get(g:, 'startify_custom_header', [
                \'',
                \'',
                \'        /######                                     /##    /##/##             ',
                \'       /##__  ##                                   | ##   | #|__/             ',
                \'      | ##  \__/ /######  /######  /####### /######| ##   | ##/##/######/#### ',
                \'      |  ###### /##__  ##|____  ##/##_____//##__  #|  ## / ##| #| ##_  ##_  ##',
                \'       \____  #| ##  \ ## /######| ##     | ########\  ## ##/| #| ## \ ## \ ##',
                \'       /##  \ #| ##  | ##/##__  #| ##     | ##_____/ \  ###/ | #| ## | ## | ##',
                \'      |  ######| #######|  ######|  ######|  #######  \  #/  | #| ## | ## | ##',
                \'       \______/| ##____/ \_______/\_______/\_______/   \_/   |__|__/ |__/ |__/',
                \'               | ##                                                           ',
                \'               | ##                                                           ',
                \'               |__/                                                           ',
                \'                      version : ' . g:spacevim_version . '   by : spacevim.org',
                \'',
                \ ])
    let g:startify_session_dir = $HOME .  '/.data/' . ( has('nvim') ? 'nvim' : 'vim' ) . '/session'
    let g:startify_files_number = 6
    let g:startify_list_order = [
                \ ['   My most recently used files in the current directory:'],
                \ 'dir',
                \ ['   My most recently used files:'],
                \ 'files',
                \ ['   These are my sessions:'],
                \ 'sessions',
                \ ['   These are my bookmarks:'],
                \ 'bookmarks',
                \ ]
    "let g:startify_bookmarks = [ {'c': '~/.vimrc'}, '~/.zshrc' ]
    let g:startify_update_oldfiles = 1
    let g:startify_disable_at_vimenter = 1
    let g:startify_session_autoload = 1
    let g:startify_session_persistence = 1
    "let g:startify_session_delete_buffers = 0
    let g:startify_change_to_dir = 0
    "let g:startify_change_to_vcs_root = 0  " vim-rooter has same feature
    let g:startify_skiplist = [
                \ 'COMMIT_EDITMSG',
                \ escape(fnamemodify(resolve($VIMRUNTIME), ':p'), '\') .'doc',
                \ 'bundle/.*/doc',
                \ ]
    fu! <SID>startify_mapping()
        if getcwd() == $VIM || getcwd() == expand('~')
            nnoremap <silent><buffer> <c-p> :<c-u>CtrlP ~\DotFiles<cr>
        endif
    endf
    augroup startify_map
        au!
        autocmd FileType startify nnoremap <buffer><F2> <Nop>
        autocmd FileType startify call <SID>startify_mapping()
        autocmd FileType startify set scrolloff=0
    augroup END

    let g:indentLine_color_term = 239
    let g:indentLine_color_gui = '#09AA08'
    let g:indentLine_char = '¦'
    let g:indentLine_concealcursor = 'niv' " (default 'inc')
    let g:indentLine_conceallevel = 2  " (default 2)
    let g:indentLine_fileTypeExclude = ['help', 'startify', 'vimfiler']
    let g:signify_disable_by_default = 0
    let g:signify_line_highlight = 0
    let g:tagbar_width = get(g:, 'tagbar_width', g:spacevim_sidebar_width)
    let g:tagbar_left = get(g:, 'tagbar_left', 1)
    let g:tagbar_sort = get(g:, 'tagbar_sort', 0)
    let g:tagbar_compact = get(g:, 'tagbar_compact', 1)
    noremap <silent> <F2> :TagbarToggle<CR>
endfunction
