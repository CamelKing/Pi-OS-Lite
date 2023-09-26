
" PHP Documentor {{{
"-------------------

	let g:pdv_cfg_Package = 'Theme'		" <-- customise theme name
	let g:pdv_cfg_Version = 'Version'	" <-- customise version number
	let g:pdv_cfg_Author = 'Camel'		" <-- author name
	let g:pdv_cfg_ClassTags = ["package","author","version"]
	au BufRead,BufNewFile *.php inoremap <buffer> <leader>db :call PhpDoc()<CR>
	au BufRead,BufNewFile *.php nnoremap <buffer> <leader>db :call PhpDoc()<CR>
	au BufRead,BufNewFile *.php vnoremap <buffer> <leader>db :call PhpDocRange()<CR>

" }}}

