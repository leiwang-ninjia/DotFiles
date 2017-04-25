function! SpaceVim#layers#tools#plugins() abort
  return [
        \ ['tpope/vim-scriptease'],
        \ ['SpaceVim/cscope.vim'],
        \ ['junegunn/goyo.vim',               { 'on_cmd' : 'Goyo'}],
        \ ['junegunn/limelight.vim',          { 'on_cmd' : 'Limelight'}],
        \ ['Yggdroot/LeaderF',                { 'on_cmd' : 'LeaderfFile',
        \ 'merged' : 0}],
        \ ['MattesGroeger/vim-bookmarks',     { 'on_map' : '<Plug>Bookmark'}],
        \ ['simnalamburt/vim-mundo',          { 'on_cmd' : 'MundoToggle'}],
        \ ['mhinz/vim-grepper' ,              { 'on_cmd' : 'Grepper'}],
        \ ['tpope/vim-projectionist',         { 'on_cmd' : ['A', 'AS', 'AV',
        \ 'AT', 'AD', 'Cd', 'Lcd', 'ProjectDo']}],
        \ ['ntpeters/vim-better-whitespace',  { 'on_cmd' : 'StripWhitespace'}],
        \ ['junegunn/rainbow_parentheses.vim',
        \ { 'on_cmd' : 'RainbowParentheses'}],
        \ ['godlygeek/tabular',           { 'on_cmd' : 'Tabularize'}],
        \ ['airblade/vim-gitgutter',      { 'on_cmd' : 'GitGutterEnable'}],
        \ ['junegunn/fzf',                { 'on_cmd' : 'FZF'}],
        \ ['TaskList.vim',                { 'on_cmd' : 'TaskList'}],
        \ ['taglist.vim',         { 'on_cmd' : 'TlistToggle'}],
        \ ['scrooloose/nerdtree', { 'on_cmd' : 'NERDTreeToggle'}],
        \ ['Xuyuanp/nerdtree-git-plugin'],
        \ ]
endfunction

function! SpaceVim#layers#tools#config() abort
  nmap mm <Plug>BookmarkToggle
  nmap mi <Plug>BookmarkAnnotate
  nmap ma <Plug>BookmarkShowAll
  nmap mn <Plug>BookmarkNext
  nmap mp <Plug>BookmarkPrev
  nmap <Leader>m <Plug>BookmarkToggle
  nmap <Leader>mi <Plug>BookmarkAnnotate
  nmap <Leader>ma <Plug>BookmarkShowAll
  nmap <Leader>mj <Plug>BookmarkNext
  nmap <Leader>mk <Plug>BookmarkPrev
  nmap <Leader>mc <Plug>BookmarkClear
  nmap <Leader>mx <Plug>BookmarkClearAll
  nnoremap <silent> <F7> :MundoToggle<CR>
  augroup rainbow_lisp
    autocmd!
    autocmd FileType lisp,clojure,scheme,java RainbowParentheses
  augroup END
  let g:rainbow#max_level = 16
  let g:rainbow#pairs = [['(', ')'], ['[', ']'],['{','}']]
  " List of colors that you do not want. ANSI code or #RRGGBB
  let g:rainbow#blacklist = [233, 234]
  nnoremap <Leader>fz :FZF<CR>
  if maparg('<C-l>', 'v') ==# ''
    vnoremap <silent> <C-l> <Esc>:Ydv<CR>
  endif
  if maparg('<C-l>', 'n') ==# ''
    nnoremap <silent> <C-l> <Esc>:Ydc<CR>
  endif
  map <unique> <Leader>td <Plug>TaskList
  noremap <silent> <F8> :TlistToggle<CR>
  function! OpenOrCloseNERDTree() abort
    exec 'normal! A'
  endfunction
  if g:spacevim_filemanager ==# 'nerdtree'
    noremap <silent> <F3> :NERDTreeToggle<CR>
  endif
  let g:NERDTreeWinPos=get(g:,'NERDTreeWinPos','right')
  let g:NERDTreeWinSize=get(g:,'NERDTreeWinSize',31)
  let g:NERDTreeChDirMode=get(g:,'NERDTreeChDirMode',1)
  augroup nerdtree_zvim
    autocmd!
    autocmd bufenter *
          \ if (winnr('$') == 1 && exists('b:NERDTree')
          \ && b:NERDTree.isTabTree())
          \|   q
          \| endif
    autocmd FileType nerdtree nnoremap <silent><buffer><Space>
          \ :call OpenOrCloseNERDTree()<cr>
  augroup END
  if !executable('ctags')
    let g:Tlist_Ctags_Cmd = get(g:, 'Tlist_Ctags_Cmd', '/usr/bin/ctags')  "设置ctags执行路径
  endif
  let g:Tlist_Auto_Update = get(g:, 'Tlist_Auto_Update', 1)
  let g:Tlist_Auto_Open = get(g:, 'Tlist_Auto_Open', 0)
  let g:Tlist_Use_Right_Window = get(g:, 'Tlist_Use_Right_Window', 1)
  let g:Tlist_Show_One_File = get(g:, 'Tlist_Show_One_File', 0)
  let g:Tlist_File_Fold_Auto_Close = get(g:, 'Tlist_File_Fold_Auto_Close', 1)
  let g:Tlist_Exit_OnlyWindow = get(g:, 'Tlist_Exit_OnlyWindow', 1)
  let g:Tlist_Show_Menu = get(g:, 'Tlist_Show_Menu', 1)
endfunction

" vim:set et sw=2 cc=80:
