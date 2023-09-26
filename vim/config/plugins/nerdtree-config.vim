
" NerdTREE {{{
"-------------

	"no disp bookmark(B) and help(?)
	let NERDTreeMinimalUI = 1
	" show line number
	let NERDTreeShowLineNumbers = 1
	" focus on file when swicth to tab
	let g:nerdtree_tabs_focus_on_files = 1
	" store bookmarks file here ! must use expand() for full path
	let g:NERDTreeBookmarksFile = expand('~/.vim/etc/.NERDTreeBookmarks')
	" auto open NERDTree if vim open with no file
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
	" toogle NERDTree
	nnoremap <leader>nt :NERDTreeToggle<CR>
	nnoremap <leader>nv :NERDTreeToggleVCS<CR>
	nnoremap <leader>nf :NERDTreeFind<CR>

"}}}

