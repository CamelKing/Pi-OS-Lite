" Vim color file
" Maintainer: Camel King
" Last Changed: 2020-01
" Original: David Ne\v{c}as (Yeti) <yeti@physics.muni.cz>
" Last Change: 2003-04-23

" First remove all existing highlighting.
" set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif

let colors_name = "peach_dark"

hi Normal guibg=PeachPuff guifg=Black

hi SpecialKey term=bold ctermfg=DarkBlue  guifg=Blue
hi NonText term=bold cterm=bold ctermfg=DarkBlue gui=bold guifg=Blue
hi Directory term=bold ctermfg=DarkBlue guifg=Blue
hi ErrorMsg term=standout cterm=bold ctermfg=Gray ctermbg=DarkRed gui=bold guifg=White guibg=Red
hi IncSearch term=reverse cterm=reverse gui=reverse
hi Search term=reverse ctermbg=Brown guibg=Gold2
hi MoreMsg term=bold ctermfg=DarkGreen gui=bold guifg=SeaGreen
hi ModeMsg term=bold cterm=bold gui=bold
" hi LineNr term=underline ctermfg=Brown guifg=Red3
hi LineNr term=underline ctermfg=236 guifg=Red3
hi Question term=standout ctermfg=DarkGreen gui=bold guifg=SeaGreen
hi StatusLine term=bold,reverse cterm=bold,reverse gui=bold guifg=White guibg=Black
hi StatusLineNC term=reverse cterm=reverse gui=bold guifg=PeachPuff guibg=Gray45
hi VertSplit term=reverse cterm=reverse gui=bold guifg=White guibg=Gray45
hi Title term=bold ctermfg=DarkMagenta gui=bold guifg=DeepPink3
hi Visual term=reverse cterm=reverse gui=reverse guifg=Grey80 guibg=fg
hi VisualNOS term=bold,underline cterm=bold,underline gui=bold,underline
hi WarningMsg term=standout ctermfg=DarkRed gui=bold guifg=Red
hi WildMenu term=standout ctermfg=Black ctermbg=Brown guifg=Black guibg=Yellow
" hi Folded term=standout ctermfg=DarkBlue ctermbg=Gray guifg=Black guibg=#e3c1a5
hi Folded term=standout ctermfg=Gray ctermbg=240 guifg=Black guibg=#e3c1a5
hi FoldColumn term=standout ctermfg=DarkBlue ctermbg=Gray guifg=DarkBlue guibg=Gray80
" hi DiffAdd term=bold ctermbg=DarkBlue guibg=White
hi DiffAdd term=bold cterm=bold ctermfg=Green ctermbg=NONE guibg=White
hi DiffChange term=bold cterm=bold ctermbg=Yellow ctermbg=NONE guibg=#edb5cd
hi DiffDelete term=bold cterm=bold ctermfg=Red ctermbg=NONE gui=bold guifg=LightBlue guibg=#f6e8d0
hi DiffText term=reverse cterm=bold ctermbg=DarkRed ctermbg=NONE gui=bold guibg=#ff8060
hi SignColumn ctermbg=NONE cterm=NONE guibg=NONE gui=NONE
hi Cursor guifg=bg guibg=fg
hi lCursor guifg=bg guibg=fg


" Colors for syntax highlighting
hi Comment term=bold ctermfg=DarkBlue guifg=#406090
hi Constant term=underline ctermfg=Brown guifg=#c00058
hi Special term=bold ctermfg=DarkMagenta guifg=SlateBlue
hi Identifier term=underline ctermfg=DarkCyan guifg=DarkCyan
hi Statement term=bold ctermfg=Yellow gui=bold guifg=Brown
hi PreProc term=underline ctermfg=DarkMagenta guifg=Magenta3
hi Type term=underline ctermfg=DarkGreen gui=bold guifg=SeaGreen
hi Ignore cterm=bold ctermfg=Gray guifg=bg
hi Error term=reverse cterm=bold ctermfg=Gray ctermbg=DarkRed gui=bold guifg=White guibg=Red
hi Todo term=standout ctermfg=Black ctermbg=Brown guifg=Blue guibg=Yellow

