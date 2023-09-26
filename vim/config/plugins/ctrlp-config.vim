
" CtrlP {{{
"----------

	let g:ctrlp_map = '<c-p>'
	let g:ctrlp_cmd = 'CtrlP'
	" follow symlinks
	let g:ctrlp_follow_symlinks = 2
	"mode 'ra' = look for .gitignore up the dir hierachy
	let g:ctrlp_working_path_mode = 'ra'
	let g:ctrlp_brief_prompt=1 "exit when backspace at empty prompt
	set wildignore+=*/tmp/*,*.so,*.swp,*.zip
	
	" ignore the following directories, files and links
	" this wont be in effect as we have a custom command using rg 
	" defined below 
	" - ignore files pattern
	" let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
	" - ignore dir/file/links
	" let g:ctrlp_custom_ignore = {
	" \ 'dir' : '\v[\/]\.(git|hg|svn|tmp)$',
	" \ 'file': '\v\.(swp|so|swp)$',
	" \ 'link': 'some_bad_symbolic_links',
	" \ }
	"
	let g:ctrlp_custom_ignore = {
	\ 'dir' : '\v[\/]\.(git|hg|svn|tmp)$',
	\ 'file': '\v\.(swp|so)$',
	\ }

	" making use of rg to search thru files within the 
	" git repos, and ignore files/dirs listed in .gitignore
	if executable('rg')
		" ignore files specified in .gitignore
		let g:ctrlp_user_command = [
		\ '.git/',
		\ 'rg %s --smart-case --files --hidden --color=never --glob ""'
		\ ]
	else
		" ask git to list files in repo instead, accurate but not fast
		let g:ctrlp_user_command = [
		\ '.git/',
		\ 'git --git-dir=%s/.git ls-files -oc --exclude-standard'
		\ ]
	endif

"}}}
