"=============================================================================
" autocmd.vim --- main autocmd group for spacevim
" Copyright (c) 2016-2017 Shidong Wang & Contributors
" Author: Shidong Wang < wsdjeg at 163.com >
" URL: https://spacevim.org
" License: MIT license
"=============================================================================

"autocmds
function! SpaceVim#autocmds#init() abort
  augroup SpaceVim_core
    au!
    au BufWritePost vimrc,.vimrc nested if expand('%') !~ 'fugitive' | source % | endif

    " File types
    au FileType slim IndentLinesEnable

    " File types
    au BufNewFile,BufRead *.icc               set filetype=cpp
    au BufNewFile,BufRead *.pde               set filetype=java
    au BufNewFile,BufRead *.coffee-processing set filetype=coffee
    au BufNewFile,BufRead Dockerfile*         set filetype=dockerfile

    " http://vim.wikia.com/wiki/Highlight_unwanted_spaces
    au BufNewFile,BufRead,InsertLeave * silent! match ExtraWhitespace /\s\+$/
    au InsertEnter * silent! match ExtraWhitespace /\s\+\%#\@<!$/

    " Unset paste on InsertLeave
    au InsertLeave * silent! set nopaste

    autocmd BufWinEnter quickfix nnoremap <silent> <buffer>
          \   q :cclose<cr>:lclose<cr>
    autocmd BufEnter * if (winnr('$') == 1 && &buftype ==# 'quickfix' ) |
          \   bd|
          \   q | endif
    "autocmd FileType jsp call JspFileTypeInit()
    autocmd FileType html,css,jsp EmmetInstall
    autocmd BufRead,BufNewFile *.pp setfiletype puppet
    autocmd BufEnter,WinEnter,InsertLeave * set cursorline
    autocmd BufLeave,WinLeave,InsertEnter * set nocursorline
    autocmd BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
          \   exe "normal! g`\"" |
          \ endif
    autocmd BufNewFile,BufEnter * set cpoptions+=d " NOTE: ctags find the tags file from the current path instead of the path of currect file
    autocmd BufEnter * :syntax sync fromstart " ensure every file does syntax highlighting (full)
    autocmd BufNewFile,BufRead *.avs set syntax=avs " for avs syntax file.
    autocmd FileType text setlocal textwidth=78 " for all text files set 'textwidth' to 78 characters.
    autocmd FileType c,cpp,cs,swig set nomodeline " this will avoid bug in my project with namespace ex, the vim will tree ex:: as modeline.
    autocmd FileType c,cpp,java,javascript set comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,f://
    autocmd FileType cs set comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,f:///,f://
    autocmd FileType vim set comments=sO:\"\ -,mO:\"\ \ ,eO:\"\",f:\"
    autocmd FileType lua set comments=f:--
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd Filetype html setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd BufEnter *
          \   if empty(&buftype) && has('nvim') && &filetype != 'help'
          \|      nnoremap <silent><buffer> <C-]> :call <SID>MyTagfunc()<CR>
          \|      nnoremap <silent><buffer> <C-[> :call <SID>MyTagfuncBack()<CR>
          \|  else
            \|      nnoremap <silent><buffer> <leader>] :call <SID>MyTagfunc()<CR>
            \|      nnoremap <silent><buffer> <leader>[ :call <SID>MyTagfuncBack()<CR>
            \|  endif

    function! s:MyTagfunc() abort
      mark H
      let s:MyTagfunc_flag = 1
      UniteWithCursorWord -immediately tag
    endfunction

    function! s:MyTagfuncBack() abort
      if exists('s:MyTagfunc_flag')&&s:MyTagfunc_flag
        exe "normal! `H"
        let s:MyTagfunc_flag =0
      endif
    endfunction
    "}}}
    "let g:spacevim_keep_trailing_whitespace = 1
    autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> if !exists('g:spacevim_keep_trailing_whitespace') | call StripTrailingWhitespace() | endif
    " Instead of reverting the cursor to the last position in the buffer, we
    " set it to the first line when editing a git commit message
    au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
    "autocmd InsertEnter * call s:fixindentline()
    autocmd VimEnter * if !argc() | call SpaceVim#welcome() | endif
  augroup END
endfunction

" vim:set et sw=2:
