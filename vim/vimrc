scriptencoding utf-8

" Identify platform {
let g:OSX = has('macunix')
let g:LINUX = has('unix') && !has('macunix') && !has('win32unix')
let g:WINDOWS = has('win32') || has('win64')
" }

" Windows Compatible {
" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
" across (heterogeneous) systems easier.
if g:WINDOWS
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif
" }

execute 'source' fnamemodify(expand('<sfile>'), ':h').'/config/better-default.vim'

let g:spacevim_dir = fnamemodify(expand('<sfile>'), ':h')
let g:spacevim_version = '0.5.0'

call spacevim#begin()
call spacevim#end()
