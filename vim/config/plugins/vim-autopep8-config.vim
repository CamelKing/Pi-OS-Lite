autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>
" do not fix these errors and warnings
" let g:autopep8_ignore="E226,E24,W50,W690"
" fix only these errors and warnings
" let g:autopep8_select="E4,W"
" number of additional pep8 passes
let g:autopep8_pep8_passes=100
" max allowed line length
let g:autopep8_max_line_length=79
" add aggressive option (--aggressive)
"let g:autopep8_aggressive=1
" add more aggressive options (--aggressive --aggressive)
let g:autopep8_aggressive=2
" number of spaces per indent level
let g:autopep8_indent_size=4
" disable show diff window
let g:autopep8_disable_show_diff=1
" diff window type
let g:autopep8_diff_type='horizontal'
" let g:autopep8_diff_type='vertical'
" auto format on save
let g:autopep8_on_save = 1
