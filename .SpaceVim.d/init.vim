
set noexpandtab

" use space as `<Leader>`
let mapleader = "\<space>"

let g:spacevim_default_indent = 2
let g:spacevim_max_column     = 80
let g:spacevim_enable_guicolors = 0

" Set windows shortcut leader [Window], default is `s`
let g:spacevim_windows_leader = '\'

" Set unite work flow shortcut leader [Unite], default is `f`
let g:spacevim_unite_leader = ',,'

let g:spacevim_denite_leader = ','

" Enable/Disable realtime leader guide. Default is 0.
let g:spacevim_realtime_leader_guide = 1

" SpaceVim default checker is neomake. If you want to use syntastic, use:
let g:spacevim_enable_neomake = 1

let g:spacevim_colorscheme_default = 'gruvbox'

" Enable/disable simple mode of SpaceVim. Default is 0. In this mode, only few
" plugins will be installed.
let g:spacevim_simple_mode = 0
"let g:spacevim_guifont = 'DejaVu\ Sans\ Mono\ for\ Powerline\ 11'
"let g:spacevim_enable_ycm = 1
"let g:spacevim_enable_cursorline = 1
"let g:spacevim_error_symbol = '+'
"let g:spacevim_warning_symbol = '!'
"let g:spacevim_language = 'en_US.utf8'
"let g:spacevim_checkinstall = 1
"let g:spacevim_filemanager= 'NERDTree'
"let g:spacevim_pluginmanager= 'dein'
"let g:spacevim_enable_debug = 1
"let  g:spacevim_debug_level=1
"let  g:spacevim_buffer_index_type=1
"let g:spacevim_enable_tabline_filetype_icon = 1
"let g:spacevim_enable_os_fileformat_icon=1
"let g:spacevim_plugin_groups = ['core', 'lang']
"let g:spacevim_disabled_plugins = ['vim-foo', 'vim-bar']
"  let g:spacevim_custom_plugins = [
"              \ ['plasticboy/vim-markdown', 'on_ft' : 'markdown'],
"              \ ['wsdjeg/GitHub.vim'],
"              \ ]
" let g:spacevim_enable_powerline_fonts=1
let g:spacevim_lint_on_save = 0
let g:spacevim_enable_vimfiler_welcome = 0

"nnoremap <space>w :w<cr>

nnoremap <space>q :q<CR>
nnoremap  [q  :cprev<CR>
nnoremap  ]q  :cprev<CR>
nnoremap  [l  :lprev<CR>
nnoremap  ]l  :lprev<CR>

nnoremap <Leader>ff :FZF<CR>


