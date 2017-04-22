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

