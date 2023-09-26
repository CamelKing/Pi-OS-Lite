
" Autotag {{{
"------------

	" automatically search upwards for tags file,
	" remove all tags for current source file,
	" and reappend all tags from current source file
	" * this is necessary because ctags does not remove old tags
	let g:autotagStartMethod='fork' " work around python 3.8 in osx with spawn
	let g:autotagCtagsCmd='ctags -R --fields=+aimlS'
	let g:autotagTagsFile="tags"

" }}}

