
" Airlines {{{
"-------------

	" use the terminal theme for airline
	let g:airline_theme='bubblegum'
	" FIXME: 
	" setup the extensions for airlines
	" let g:airline_extensions = ['branch', 'tabline']
	" show buffer number
	let g:airline#extensions#tabline#buffer_nr_show = 0
	let g:airline#extensions#tabline#buffer_idx_mode = 1
	" the plugin not mapping the keys for some reason
  nmap <leader>1 <Plug>AirlineSelectTab1
  nmap <leader>2 <Plug>AirlineSelectTab2
  nmap <leader>3 <Plug>AirlineSelectTab3
  nmap <leader>4 <Plug>AirlineSelectTab4
  nmap <leader>5 <Plug>AirlineSelectTab5
  nmap <leader>6 <Plug>AirlineSelectTab6
  nmap <leader>7 <Plug>AirlineSelectTab7
  nmap <leader>8 <Plug>AirlineSelectTab8
  nmap <leader>9 <Plug>AirlineSelectTab9
  nmap <leader>- <Plug>AirlineSelectPrevTab
  nmap <leader>+ <Plug>AirlineSelectNextTab
	" show tab number
	let g:airline#extensions#tabline#show_tab_nr = 0
	let g:airline#extensions#tabline#tab_nr_type = 1
	" do not display close tab button 'X'
	let g:airline#extensions#tabline#show_close_button = 0
	" enable tabline on top of screen
	let g:airline#extensions#tabline#enabled = 1
	" setup the filename formatter
	" let g:airline#extensions#tabline#formatter = 'short_path'
	let g:airline#extensions#tabline#formatter = 'unique_tail'
	let g:airline#extensions#tabline#fnamecollapse = 0
	" dont need whitespace checking
	let g:airline#extensions#whitespace#enabled = 0
	" let g:airline#extensions#whitespace#checks = [
	"	\ 'indent',
	"	\ 'trailing',
	"	\ 'long',
	"	\ 'mixed-indent-file',
	"	\ 'conflicts'
	"	\ ]
	" let g:airline#extensions#whitespace#mixed_indent_algo = 2
	" disable syntastic extension for tabline as well
	let g:airline#extensions#syntastic#enabled = 0

	" the follow section format the statusline and make it more compact
	let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V',
    \ '' : 'V',
    \ 's'  : 'S',
    \ }

	" compress buffer position
	" let g:airline_section_z = '%3p%% %3l/%L:%3v'
	let g:airline_section_z = '%p%% %l/%L:%v'

	" shorten word count
	let g:airline#extensions#wordcount#format = '%d w'

	"hide unix utf-8
	let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

	" skip empty sections
	let g:airline_skip_empty_sections = 1

	"}}}

