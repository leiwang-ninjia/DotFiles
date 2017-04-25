""
" @section colorscheme, colorscheme
" @parentsection layers
" The ldefault colorscheme for SpaceVim is gruvbox. The colorscheme can be
" changed with the `g:spacevim_colorscheme` option by adding the following
" line to your `~/.SpaceVim/init.vim`.
" >
"   let g:spacevim_colorscheme = 'solarized'
" <
" 
" The following colorschemes are include in SpaceVim. If the colorscheme you
" want is not included in the list below, a PR is welcome.
" 
" Also, there's one thing which everyone should know and pay attention to.
" NOT all of below colorschemes support spell check very well. For example,
" a colorscheme called atom doesn't support spell check very well. 
"
" SpaceVim is not gonna fix them since these should be in charge of each author.
" You can see a list which has no support of spell check in here:
" https://github.com/SpaceVim/SpaceVim/issues/209#issuecomment-280545818
"
" >
"   anderson
"   apprentice
"   atom
"   base16-3024
"   base16-apathy
"   base16-ashes
"   base16-atelier-cave
"   base16-atelier-dune
"   base16-atelier-estuary
"   base16-atelier-forest
"   base16-atelier-heath
"   base16-atelier-lakeside
"   base16-atelier-plateau
"   base16-atelier-savanna
"   base16-atelier-seaside
"   base16-atelier-sulphurpool
"   base16-bespin
"   base16-brewer
"   base16-bright
"   base16-chalk
"   base16-codeschool
"   base16-cupcake
"   base16-darktooth
"   base16-default-dark
"   base16-default-light
"   base16-dracula
"   base16-eighties
"   base16-embers
"   base16-flat
"   base16-github
"   base16-google-dark
"   base16-google-light
"   base16-grayscale-dark
"   base16-grayscale-light
"   base16-green-screen
"   base16-harmonic16-dark
"   base16-harmonic16-light
"   base16-hopscotch
"   base16-ir-black
"   base16-isotope
"   base16-london-tube
"   base16-macintosh
"   base16-marrakesh
"   base16-materia
"   base16-mexico-light
"   base16-mocha
"   base16-monokai
"   base16-ocean
"   base16-oceanicnext
"   base16-onedark
"   base16-paraiso
"   base16-phd
"   base16-pico
"   base16-pop
"   base16-railscasts
"   base16-seti-ui
"   base16-shapeshifter
"   base16-solar-flare
"   base16-solarized-dark
"   base16-solarized-light
"   base16-spacemacs
"   base16-summerfruit-dark
"   base16-summerfruit-light
"   base16-tomorrow
"   base16-tomorrow-night
"   base16-twilight
"   base16-unikitty-dark
"   base16-unikitty-light
"   base16-woodland
"   blue
"   darkblue
"   default
"   delek
"   desert
"   elflord
"   evening
"   flatcolor
"   flattened_dark
"   flattened_light
"   focuspoint
"   gruvbox
"   hybrid
"   hybrid-material
"   hybrid_material
"   hybrid_reverse
"   industry
"   janah
"   jellybeans
"   koehler
"   lightning
"   lucius
"   molokai
"   molokayo
"   morning
"   murphy
"   OceanicNext
"   OceanicNextLight
"   onedark
"   pablo
"   PaperColor
"   parsec
"   peachpuff
"   pyte
"   rdark-terminal2
"   ron
"   scheakur
"   seoul256
"   seoul256-light
"   shine
"   slate
"   solarized
"   torte
"   twilight256
"   wombat256mod
"   yowish
"   zellner
" <


function! SpaceVim#layers#colorscheme#plugins() abort
    return [
                \ ['morhetz/gruvbox'],
                \ ['altercation/vim-colors-solarized'],
                \ ['nanotech/jellybeans.vim'],
                \ ['mhartington/oceanic-next'],
                \ ['Gabirel/molokai'],
                \ ['vim-scripts/wombat256.vim'],
                \ ['vim-scripts/twilight256.vim'],
                \ ['junegunn/seoul256.vim'],
                \ ['joshdick/onedark.vim'],
                \ ['gregsexton/Atom'],
                \ ['romainl/Apprentice'],
                \ ['icymind/NeoSolarized'],
                \ ]
endfunction
