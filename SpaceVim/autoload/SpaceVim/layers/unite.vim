function! SpaceVim#layers#unite#plugins() abort
    let plugins = [
                \ ['Shougo/unite.vim',{ 'merged' : 0 , 'loadconf' : 1}],
                \ ['Shougo/neoyank.vim'],
                \ ['Shougo/neomru.vim'],
                \ ['Shougo/unite-outline'],
                \ ['hewes/unite-gtags' ,{'loadconf' : 1}],
                \ ['tsukkee/unite-tag'],
                \ ['Shougo/unite-help'],
                \ ['mileszs/ack.vim',{'on_cmd' : 'Ack'}],
                \ ['albfan/ag.vim',{'on_cmd' : 'Ag' , 'loadconf' : 1}],
                \ ['dyng/ctrlsf.vim',{'on_cmd' : 'CtrlSF', 'on_map' : '<Plug>CtrlSF', 'loadconf' : 1, 'loadconf_before' : 1}],
                \ ['Shougo/unite-session'],
                \ ['osyo-manga/unite-quickfix'],
                \ ['lambdalisue/unite-grep-vcs', {
                \ 'autoload': {
                \    'unite_sources': ['grep/git', 'grep/hg'],
                \ }}],
                \ ]

    if g:spacevim_filemanager ==# 'vimfiler'
        call add(plugins, ['Shougo/vimfiler.vim',{'merged' : 0, 'loadconf' : 1 , 'loadconf_before' : 1}])
    endif
    return plugins
endfunction

function! SpaceVim#layers#unite#config() abort
endfunction
