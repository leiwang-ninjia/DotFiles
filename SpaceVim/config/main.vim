
"Detect OS
let g:OSX = has('macunix')
let g:LINUX = has('unix') && !has('macunix') && !has('win32unix')
let g:WINDOWS = (has('win16') || has('win32') || has('win64'))

" Fsep
if g:WINDOWS
    let s:Fsep = '\'
else
    let s:Fsep = '/'
endif

let g:Config_Main_Home = fnamemodify(expand('<sfile>'), ':p:h:gs?\\?s.Fsep?')

function! s:source_rc(file) abort
    if filereadable(g:Config_Main_Home. '/' . a:file)
        execute 'source ' . g:Config_Main_Home  . '/' . a:file
    endif
endfunction

try
    call <SID>source_rc('functions.vim')
    execute 'set runtimepath +=' . fnamemodify(g:Config_Main_Home, ':p:h:h') . s:Fsep . 'core'
catch
    execute 'set runtimepath +=' . fnamemodify(g:Config_Main_Home, ':p:h:h')
    execute 'set runtimepath +=' . fnamemodify(g:Config_Main_Home, ':p:h:h') . s:Fsep . 'core'
    call <SID>source_rc('functions.vim')
endtry

call <SID>source_rc('init.vim')

call spacevim#begin()

call SpaceVim#default()

call SpaceVim#loadCustomConfig()

call SpaceVim#end()

call <SID>source_rc('general.vim')

" Layer 'spacevim'

"call spacevim#end()

call SpaceVim#autocmds#init()

if has('nvim')
    call <SID>source_rc('neovim.vim')
endif


filetype plugin indent on
syntax on
