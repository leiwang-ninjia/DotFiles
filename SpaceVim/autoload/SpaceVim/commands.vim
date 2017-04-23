function! SpaceVim#commands#load() abort
  ""
  " Load exist layer, {layers} can be a string of a layer name, or a list
  " of layer names.
  command! -nargs=+ SPLayer call SpaceVim#commands#loadlayers(<f-args>)
  ""
  ""
  " edit custom config file of SpaceVim, by default this command will open
  " global custom configuration file, '-l' option will load local custom
  " configuration file.
  " >
  "   :SPConfig -g
  " <
  command! -nargs=*
        \ -complete=customlist,SpaceVim#commands#complete_SPConfig
        \ SPConfig call SpaceVim#commands#config(<f-args>)
  ""
  " Command for update plugin, support completion of plugin name.
  " >
  "     :SPUpdate vim-airline
  " <
  command! -nargs=*
        \ -complete=custom,SpaceVim#commands#complete_plugin
        \ SPUpdate call SpaceVim#commands#update_plugin(<f-args>)

endfunction

function! SpaceVim#commands#loadlayers(layer, ...) abort
  if index(g:spacevim_plugin_groups, a:layer) == -1
    call add(g:spacevim_plugin_groups, a:layer)
  endif
  if a:0 > 1
    for l in a:000
      call SpaceVim#commands#loadlayers(l)
    endfor
  endif
endfunction

function! SpaceVim#commands#complete_plugin(ArgLead, CmdLine, CursorPos) abort
  return join(keys(dein#get()), "\n")
endfunction

function! SpaceVim#commands#complete_SPConfig(ArgLead, CmdLine, CursorPos) abort
  return ['-g', '-l']
endfunction

function! SpaceVim#commands#config(...) abort
  if (a:0 > 0 && a:1 ==# '-g') || a:0 == 0
    tabnew ~/.SpaceVim.d/init.vim
  elseif  a:0 > 0 && a:1 ==# '-l'
    tabnew .SpaceVim.d/init.vim
  endif
endfunction

function! SpaceVim#commands#update_plugin(...) abort
  if g:spacevim_plugin_manager ==# 'neobundle'
  elseif g:spacevim_plugin_manager ==# 'dein'
    if a:0 == 0
      call dein#update()
    else
      call dein#install(a:000)
    endif
  elseif g:spacevim_plugin_manager ==# 'vim-plug'
  endif
endfunction

" vim:set et sw=2 cc=80:
