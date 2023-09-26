
" Signify {{{
"------------

	let g:signify_vcs_list = [ 'git' ]

	let g:signify_sign_show_text = 1
	highlight SignifySignAdd    ctermbg=NONE ctermfg=green
	highlight SignifySignDelete ctermbg=NONE ctermfg=red
	highlight SignifySignChange ctermbg=NONE ctermfg=yellow

	highlight SignColumn ctermbg=NONE cterm=NONE guibg=NONE gui=NONE


	nnoremap <leader>gt :SignifyToggle<cr>
	nnoremap <leader>gd :SignifyDiff<cr>
	nnoremap <leader>gp :SignifyHunkDiff<cr>
	nnoremap <leader>gu :SignifyHunkUndo<cr>

	" hunk jumping
	nmap <leader>gj <plug>(signify-next-hunk)
	nmap <leader>gk <plug>(signify-prev-hunk)

	" hunk text object
	omap ic <plug>(signify-motion-inner-pending)
	xmap ic <plug>(signify-motion-inner-visual)
	omap ac <plug>(signify-motion-outer-pending)
	xmap ac <plug>(signify-motion-outer-visual)

"}}}

