""
" @section autocomplete, autocomplete
" @parentsection layers
" @subsection code completion
" SpaceVim uses neocomplete as the default completion engine if vim has lua
" support. If there is no lua support, neocomplcache will be used for the
" completion engine. Spacevim uses deoplete as the default completion engine
" for neovim. Deoplete requires neovim to be compiled with python support. For
" more information on python support, please read neovim's |provider-python|.
"
" SpaceVim includes YouCompleteMe, but it is disabled by default. To enable
" ycm, see |g:spacevim_enable_ycm|.
"
" @subsection snippet
" SpaceVim use neosnippet as the default snippet engine. The default snippets
" are provided by `Shougo/neosnippet-snippets`. For more information, please read
" |neosnippet|. Neosnippet support custom snippets, and the default snippets
" directory is `~/.SpaceVim/snippets/`. If `g:spacevim_force_global_config = 1`,
" SpaceVim will not append `./.SpaceVim/snippets` as default snippets directory.



function! SpaceVim#layers#autocomplete#plugins() abort
  let plugins = [
        \ ['honza/vim-snippets',          { 'on_i' : 1}],
        \ ['Shougo/neco-syntax',          { 'on_i' : 1}],
        \ ['ujihisa/neco-look',           { 'on_i' : 1}],
        \ ['Shougo/context_filetype.vim', { 'on_i' : 1}],
        \ ['Shougo/neoinclude.vim',       { 'on_i' : 1}],
        \ ['Shougo/neosnippet-snippets',  { 'merged' : 0}],
        \ ['Shougo/neopairs.vim',         { 'on_i' : 1}],
        \ ['Raimondi/delimitMate',        { 'merged' : 0}],
        \ ]
  " snippet
  if g:spacevim_snippet_engine ==# 'neosnippet'
    call add(plugins,  ['Shougo/neosnippet.vim', { 'on_i'  : 1 ,
          \ 'on_ft' : 'neosnippet',
          \ 'on_cmd' : 'NeoSnippetEdit'}])
  elseif g:spacevim_snippet_engine ==# 'ultisnips'
    call add(plugins, ['SirVer/ultisnips',{ 'merged' : 0 }])
  endif
  if g:spacevim_autocomplete_method ==# 'ycm'
    call add(plugins, ['ervandew/supertab',                 { 'merged' : 0}])
    call add(plugins, ['Valloric/YouCompleteMe',            { 'merged' : 0}])
  elseif g:spacevim_autocomplete_method ==# 'neocomplete'
    call add(plugins, ['Shougo/neocomplete', {
          \ 'on_i' : 1,
          \ }])
  elseif g:spacevim_autocomplete_method ==# 'neocomplcache' "{{{
    call add(plugins, ['Shougo/neocomplcache.vim', {
          \ 'on_i' : 1,
          \ }])
  elseif g:spacevim_autocomplete_method ==# 'deoplete'
    call add(plugins, ['Shougo/deoplete.nvim', {
          \ 'on_i' : 1,
          \ }])
  endif
  return plugins
endfunction


function! SpaceVim#layers#autocomplete#config() abort
  if g:spacevim_autocomplete_method ==# 'ycm'
    sunmap <S-TAB>
    iunmap <S-TAB>
    let g:SuperTabContextDefaultCompletionType = '<c-n>'
    let g:SuperTabDefaultCompletionType = '<C-n>'
    "autocmd InsertLeave * if pumvisible() ==# 0|pclose|endif
    let g:neobundle#install_process_timeout = 1500
  endif

  let g:neosnippet#snippets_directory = get(g:,'neosnippet#snippets_directory',
        \ '')
  if empty(g:neosnippet#snippets_directory)
    let g:neosnippet#snippets_directory = [expand('~/.SpaceVim/snippets/'),
          \ expand('~/.SpaceVim.d/snippets/')]
  elseif type(g:spacevim_force_global_config) == type('')
    let g:neosnippet#snippets_directory = [expand('~/.SpaceVim/snippets/'),
          \ expand('~/.SpaceVim.d/snippets/')] +
          \ [g:neosnippet#snippets_directory]
  elseif type(g:spacevim_force_global_config) == type([])
    let g:neosnippet#snippets_directory = [expand('~/.SpaceVim/snippets/'),
          \ expand('~/.SpaceVim.d/snippets/')] +
          \ g:neosnippet#snippets_directory
  endif

  if g:spacevim_force_global_config == 0
    let g:neosnippet#snippets_directory = [getcwd() . '/.Spacevim.d/snippets'] +
          \ g:neosnippet#snippets_directory
  endif
  let g:neosnippet#enable_snipmate_compatibility =
        \ get(g:, 'neosnippet#enable_snipmate_compatibility', 1)
  let g:neosnippet#enable_complete_done =
        \ get(g:, 'neosnippet#enable_complete_done', 1)

  if !exists('g:neosnippet#completed_pairs')
    let g:neosnippet#completed_pairs = {}
  endif
  let g:neosnippet#completed_pairs.java = {'(' : ')'}
  if g:neosnippet#enable_complete_done
    let g:neopairs#enable = 0
  endif

  """ {{{
  " let g:neocomplete#data_directory= get(g:, 'neocomplete#data_directory', '~/.cache/neocomplete')
  " let g:acp_enableAtStartup = get(g:, 'acp_enableAtStartup', 0)
  " let g:neocomplete#enable_at_startup = get(g:, 'neocomplete#enable_at_startup', 1)
  " " Use smartcase.
  " let g:neocomplete#enable_smart_case = get(g:, 'neocomplete#enable_smart_case', 1)
  " let g:neocomplete#enable_camel_case = get(g:, 'neocomplete#enable_camel_case', 1)
  " "let g:neocomplete#enable_ignore_case = 1
  " let g:neocomplete#enable_fuzzy_completion = get(g:, 'neocomplete#enable_fuzzy_completion', 1)
  " " Set minimum syntax keyword length.
  " let g:neocomplete#sources#syntax#min_keyword_length = get(g:, 'neocomplete#sources#syntax#min_keyword_length', 3)
  " let g:neocomplete#lock_buffer_name_pattern = get(g:, 'neocomplete#lock_buffer_name_pattern', '\*ku\*')
   """ }}}

  " Define dictionary.
  " let g:neocomplete#sources#dictionary#dictionaries = get(g:, 'neocomplete#sources#dictionary#dictionaries', {
  "       \ 'default' : '',
  "       \ 'vimshell' : $CACHE.'/vimshell/command-history',
  "       \ 'java' : '~/.vim/dict/java.dict',
  "       \ 'ruby' : '~/.vim/dict/ruby.dict',
  "       \ 'scala' : '~/.vim/dict/scala.dict',
  "       \ })

  " let g:neocomplete#enable_auto_delimiter = get(g:, 'neocomplete#enable_auto_delimiter', 1)

  " " Define keyword.
  " if !exists('g:neocomplete#keyword_patterns')
  "   let g:neocomplete#keyword_patterns = {}
  " endif
  " let g:neocomplete#keyword_patterns._ = get(g:neocomplete#keyword_patterns, '_', '\h\k*(\?')

  " " AutoComplPop like behavior.
  " let g:neocomplete#enable_auto_select = 0

  " if !exists('g:neocomplete#sources#omni#input_patterns')
  "   let g:neocomplete#sources#omni#input_patterns = {}
  " endif

  " let g:neocomplete#sources#omni#input_patterns.perl = get(g:neocomplete#sources#omni#input_patterns, 'perl', '\h\w*->\h\w*\|\h\w*::')
  " let g:neocomplete#sources#omni#input_patterns.java = get(g:neocomplete#sources#omni#input_patterns, 'java','[^. \t0-9]\.\w*')
  " let g:neocomplete#sources#omni#input_patterns.lua = get(g:neocomplete#sources#omni#input_patterns, 'lua','[^. \t0-9]\.\w*')
  " if !exists('g:neocomplete#force_omni_input_patterns')
  "   let g:neocomplete#force_omni_input_patterns = {}
  " endif
  " "let g:neocomplete#force_omni_input_patterns.java = '^\s*'
  " " <C-h>, <BS>: close popup and delete backword char.
  " inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  " inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
  " inoremap <expr><C-y>  neocomplete#close_popup()
  " inoremap <expr><C-e>  neocomplete#cancel_popup()


  "---------------------------------------------------------------------------
  " neocomplache.vim
  "
  let g:neocomplcache_enable_at_startup = get(g:, 'neocomplcache_enable_at_startup', 1)
  " Use smartcase
  let g:neocomplcache_enable_smart_case = get(g:, 'neocomplcache_enable_smart_case', 1)
  " Use camel case completion.
  let g:neocomplcache_enable_camel_case_completion = get(g:, 'neocomplcache_enable_camel_case_completion', 1)
  " Use underbar completion.
  let g:neocomplcache_enable_underbar_completion = get(g:, 'neocomplcache_enable_underbar_completion', 1)
  " Use fuzzy completion.
  let g:neocomplcache_enable_fuzzy_completion = get(g:, 'neocomplcache_enable_fuzzy_completion', 1)

  " Set minimum syntax keyword length.
  let g:neocomplcache_min_syntax_length = get(g:, 'neocomplcache_min_syntax_length', 3)
  " Set auto completion length.
  let g:neocomplcache_auto_completion_start_length = get(g:, 'neocomplcache_auto_completion_start_length', 2)
  " Set manual completion length.
  let g:neocomplcache_manual_completion_start_length = get(g:, 'neocomplcache_manual_completion_start_length', 0)
  " Set minimum keyword length.
  let g:neocomplcache_min_keyword_length = get(g:, 'neocomplcache_min_keyword_length', 3)
  " let g:neocomplcache_enable_cursor_hold_i = v:version > 703 ||
  "       \ v:version == 703 && has('patch289')
  let g:neocomplcache_enable_cursor_hold_i = get(g:, 'neocomplcache_enable_cursor_hold_i', 0)
  let g:neocomplcache_cursor_hold_i_time = get(g:, 'neocomplcache_cursor_hold_i_time', 300)
  let g:neocomplcache_enable_insert_char_pre = get(g:, 'neocomplcache_enable_insert_char_pre', 1)
  let g:neocomplcache_enable_prefetch = get(g:, 'neocomplcache_enable_prefetch', 1)
  let g:neocomplcache_skip_auto_completion_time = get(g:, 'neocomplcache_skip_auto_completion_time', '0.6')

  " For auto select.
  let g:neocomplcache_enable_auto_select = get(g:, 'neocomplcache_enable_auto_select', 0)

  let g:neocomplcache_enable_auto_delimiter = get(g:, 'neocomplcache_enable_auto_delimiter', 1)
  let g:neocomplcache_disable_auto_select_buffer_name_pattern = get(g:, 'neocomplcache_disable_auto_select_buffer_name_pattern',
        \ '\[Command Line\]')
  "let g:neocomplcache_disable_auto_complete = 0
  let g:neocomplcache_max_list = get(g:, 'neocomplcache_max_list', 100)
  let g:neocomplcache_force_overwrite_completefunc = get(g:, 'neocomplcache_force_overwrite_completefunc', 1)
  if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
  endif
  if !exists('g:neocomplcache_omni_functions')
    let g:neocomplcache_omni_functions = {}
  endif
  if !exists('g:neocomplcache_force_omni_patterns')
    let g:neocomplcache_force_omni_patterns = {}
  endif
  let g:neocomplcache_enable_auto_close_preview = get(g:, 'neocomplcache_enable_auto_close_preview', 1)
  " let g:neocomplcache_force_omni_patterns.ruby = get(g:, ': ,[^. *\t]\.\w*\|\h\w*::')
  let g:neocomplcache_omni_patterns.ruby = get(g:neocomplcache_omni_patterns, 'ruby',
        \ '[^. *\t]\.\w*\|\h\w*::')
  let g:neocomplcache_omni_patterns.java = get(g:neocomplcache_omni_patterns, 'java',
        \ '[^. *\t]\.\w*\|\h\w*::')
  let g:neocomplcache_force_omni_patterns.java = get(g:neocomplcache_force_omni_patterns, 'java',
        \ '[^. *\t]\.\w*\|\h\w*::')

  " For clang_complete.
  let g:neocomplcache_force_overwrite_completefunc = get(g:, 'neocomplcache_force_overwrite_completefunc', 1)
  let g:neocomplcache_force_omni_patterns.c = get(g:neocomplcache_force_omni_patterns, 'c',
        \ '[^.[:digit:] *\t]\%(\.\|->\)')
  let g:neocomplcache_force_omni_patterns.cpp = get(g:neocomplcache_force_omni_patterns, 'cpp',
        \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::')
  let g:clang_complete_auto = get(g:, 'clang_complete_auto', 0)
  let g:clang_auto_select = get(g:, 'clang_auto_select', 0)
  let g:clang_use_library   = get(g:, 'clang_use_library', 1)

  " Define keyword pattern.
  if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
  endif
  let g:neocomplcache_keyword_patterns['default'] = '[0-9a-zA-Z:#_]\+'
  let g:neocomplcache_keyword_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
  let g:neocomplete#enable_multibyte_completion = get(g:, 'neocomplete#enable_multibyte_completion', 1)

  let g:neocomplcache_vim_completefuncs = get(g:, 'neocomplcache_vim_completefuncs', {
        \ 'Ref' : 'ref#complete',
        \ 'Unite' : 'unite#complete_source',
        \ 'VimShellExecute' :
        \      'vimshell#vimshell_execute_complete',
        \ 'VimShellInteractive' :
        \      'vimshell#vimshell_execute_complete',
        \ 'VimShellTerminal' :
        \      'vimshell#vimshell_execute_complete',
        \ 'VimShell' : 'vimshell#complete',
        \ 'VimFiler' : 'vimfiler#complete',
        \ 'Vinarise' : 'vinarise#complete',
        \})


  " deoplete options
  let g:deoplete#enable_at_startup = get(g:, 'deoplete#enable_at_startup', 1)
  let g:deoplete#enable_ignore_case = get(g:, 'deoplete#enable_ignore_case', 1)
  let g:deoplete#enable_smart_case = get(g:, 'deoplete#enable_smart_case', 1)
  let g:deoplete#enable_camel_case = get(g:, 'deoplete#enable_camel_case', 1)
  let g:deoplete#enable_refresh_always = get(g:, 'deoplete#enable_refresh_always', 1)
  let g:deoplete#max_abbr_width = get(g:, 'deoplete#max_abbr_width', 0)
  let g:deoplete#max_menu_width = get(g:, 'deoplete#max_menu_width', 0)
  " init deoplet option dict
  let g:deoplete#ignore_sources = get(g:,'deoplete#ignore_sources',{})
  let g:deoplete#omni#input_patterns = get(g:,'deoplete#omni#input_patterns',{})
  let g:deoplete#omni_patterns = get(g:, 'deoplete#omni_patterns', {})

  " java && jsp
  let g:deoplete#omni#input_patterns.java = get(g:deoplete#omni#input_patterns, 'java', [
        \'[^. \t0-9]\.\w*',
        \'[^. \t0-9]\->\w*',
        \'[^. \t0-9]\::\w*',
        \])
  let g:deoplete#omni#input_patterns.jsp = get(g:deoplete#omni#input_patterns, 'jsp', ['[^. \t0-9]\.\w*'])
  if g:spacevim_enable_javacomplete2_py
    let g:deoplete#ignore_sources.java = get(g:deoplete#ignore_sources, 'java', ['omni'])
    call deoplete#custom#set('javacomplete2', 'mark', '')
  else
    let g:deoplete#ignore_sources.java = get(g:deoplete#ignore_sources, 'java', ['javacomplete2'])
    call deoplete#custom#set('omni', 'mark', '')
  endif

  " go
  let g:deoplete#ignore_sources.go = get(g:deoplete#ignore_sources, 'go', ['omni'])
  call deoplete#custom#set('go', 'mark', '')
  call deoplete#custom#set('go', 'rank', 9999)

  " perl
  let g:deoplete#omni#input_patterns.perl = get(g:deoplete#omni#input_patterns, 'perl', [
        \'[^. \t0-9]\.\w*',
        \'[^. \t0-9]\->\w*',
        \'[^. \t0-9]\::\w*',
        \])

  " javascript
  let g:deoplete#omni#input_patterns.javascript = get(g:deoplete#omni#input_patterns, 'javascript', ['[^. \t0-9]\.\w*'])

  " php
  let g:deoplete#omni#input_patterns.php = get(g:deoplete#omni#input_patterns, 'php', [
        \'[^. \t0-9]\.\w*',
        \'[^. \t0-9]\->\w*',
        \'[^. \t0-9]\::\w*',
        \])
  let g:deoplete#ignore_sources.php = get(g:deoplete#ignore_sources, 'php', ['phpcd', 'around', 'member'])
  "call deoplete#custom#set('phpcd', 'mark', '')
  " call deoplete#custom#set('phpcd', 'input_pattern', '\w*|[^. \t]->\w*|\w*::\w*')

  " lua
  let g:deoplete#omni_patterns.lua = get(g:deoplete#omni_patterns, 'lua', '.')

  " c c++
  call deoplete#custom#set('clang2', 'mark', '')
  let g:deoplete#ignore_sources.c = get(g:deoplete#ignore_sources, 'c', ['omni'])

  " rust
  let g:deoplete#ignore_sources.rust = get(g:deoplete#ignore_sources, 'rust', ['omni'])
  call deoplete#custom#set('racer', 'mark', '')

  " public settings
  call deoplete#custom#set('_', 'matchers', ['matcher_full_fuzzy'])
  let g:deoplete#ignore_sources._ = get(g:deoplete#ignore_sources, '_', ['around'])
  inoremap <expr><C-h> deoplete#mappings#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"
  set isfname-==

  " vim:set et sw=2:
  " vim:set et sw=2:
  " vim:set et sw=2:
endfunction


" vim:set et sw=2 cc=80:
