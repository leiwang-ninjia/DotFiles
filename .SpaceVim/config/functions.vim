"Detect OS
function! OSX()
    return has('macunix')
endfunction
function! LINUX()
    return has('unix') && !has('macunix') && !has('win32unix')
endfunction
function! WINDOWS()
    return (has('win16') || has('win32') || has('win64'))
endfunction

"function! OnmiConfigForJsp()
    "let pos1 = search("</script>","nb",line("w0"))
    "let pos2 = search("<script","nb",line("w0"))
    "let pos3 = search("</script>","n",line("w$"))
    "let pos0 = line('.')
    "if pos1 < pos2 && pos2 < pos0 && pos0 < pos3
        "set omnifunc=javascriptcomplete#CompleteJS
        "return "\<esc>a."
    "else
        "set omnifunc=javacomplete#Complete
        "return "\<esc>a."
    "endif
"endf

"function! JspFileTypeInit()
    "set tags+=~/others/openjdk-8-src/tags
    "set omnifunc=javacomplete#Complete
    "inoremap . <c-r>=OnmiConfigForJsp()<cr>
    "nnoremap <F4> :JCimportAdd<cr>
    "inoremap <F4> <esc>:JCimportAddI<cr>
"endfunction

" Strip whitespace {
function! StripTrailingWhitespace()
	" Preparation: save last search, and cursor position.
	let _s=@/
	let l = line(".")
	let c = col(".")
	" do the business:
	%s/\s\+$//e
	" clean up: restore previous search history, and cursor position
	let @/=_s
	call cursor(l, c)
endfunction
" }
