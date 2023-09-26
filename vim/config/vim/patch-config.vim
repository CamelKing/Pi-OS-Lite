" Place all patching routines for error avoidance in this file
" Make sure to only source this file last in .vimrc

" Misc. neccessity
"=================

	" Clear Matches {{{
	"------------------

		" clear macthes to avoid memory leaks
		if version >= 702
			autocmd BufWinLeave * call clearmatches()
		endif

	"}}}

	" PHP Code Color Correction {{{
	"------------------------------

		function! PhpSyntaxOverride()
			" color code tags and param in PHPDoc comment section
			hi! link phpDocTags phpDefine
			hi! link phpDocParam phpType
			hi! phpFunction term=underline cterm=none ctermfg=Cyan guifg=DarkCyan
			" color code namespace separator
			" highlight phpClassNamespaceSeparator
			" \	ctermfg=yellow ctermbg=NONE guifg=#808080 guibg=NONE gui=NONE
			" highlight! link phpUseNamespaceSeparator phpClassNamespaceSeparator
			" highlight! link phpDocNamespaceSeparator phpClassNamespaceSeparator
		endfunction

		augroup phpSyntaxOverride
			autocmd!
			autocmd FileType php call PhpSyntaxOverride()
		augroup END

	"}}}

	" make black background regardless of color theme {{{
	"----------------------------------------------------
	highlight normal ctermbg=black	
	" }}}
