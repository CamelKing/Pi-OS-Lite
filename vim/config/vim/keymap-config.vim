
" General key mapping
"====================

	" key mapping settings {{{

		set langnoremap		" remove backward compatibility

	" }}}

	" display {{{
	"------------

		" toggle presentation mode
		" relativenumber, number, showmode showcmd hidden ruler
		nmap <F5> :set rnu! nu! smd! sc! hid! ru!<CR> :set laststatus=0<CR>
		" toggle list char display
		nnoremap <leader>dl :set list!<CR>

	"}}}

	" tab and buffer {{{
	"-------------------
	
		" load all buffers into tab
		nnoremap <leader>tb :tab sball<CR>
		" Close current tab
		nnoremap <leader>tc :tabclose<CR>
		" open new tab
		nnoremap <leader>t= :tabnew<CR>
		" close all except current
		nnoremap <leader>to :tabo<CR>
		" next tab
		nnoremap <leader>tn :tabn<CR>
		" previous tab
		nnoremap <leader>tp :tabp<CR>
		" move tab right
		nnoremap <leader>tmr :tabm+1<CR>
		" move tab left
		nnoremap <leader>tml :tabm-1<CR>
		" switch to first tab
		nnoremap <leader>tf :tabfirst<CR>
		" switch to last tab
		nnoremap <leader>tl :tablast<CR>
		" next buffer
		nnoremap <leader>bn :bn<CR>
		" previous buffer
		nnoremap <leader>bp :bp<CR>
		" close buffer
		nnoremap <leader>bc :bd<CR>

	"}}}

	" windows {{{
	"-------------------

		" switch to window on left, down, up, right
		map <leader>h :wincmd h<CR>
		map <leader>j :wincmd j<CR>
		map <leader>k :wincmd k<CR>
		map <leader>l :wincmd l<CR>

		" open window full screen
		nnoremap <silent> <leader>wo :wincmd o<CR>
		" create a new window and an empty file
		nnoremap <silent> <leader>wn :wincmd n<CR>
		" close a window (no quit)
		nnoremap <silent> <leader>wc :wincmd c<CR>
		" quit a window
		nnoremap <silent> <leader>wq :wincmd q<CR>
		" vertical split
		nnoremap <silent> <leader>vs :vs<CR>
		" side split
		nnoremap <silent> <leader>sp :sp<CR>

		" resize vertical window
		nnoremap <silent> <leader>vr :vertical resize 30<CR>
		nnoremap <silent> <leader>v= :vertical resize +5<CR>
		nnoremap <silent> <leader>v- :vertical resize -5<CR>

		" resize split window
		nnoremap <silent> <leader>sr :resize 20<CR>
		nnoremap <silent> <leader>s= :resize +5<CR>
		nnoremap <silent> <leader>s- :resize -5<CR>

	" }}}

	" search and replace {{{
	"-----------------------

		" find (and highlight) current word under cursor
		nnoremap <silent> <leader>fw :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>
		" remove search item highlight
		nnoremap <silent> <BS> :noh<CR>

	"}}}

	" edit {{{
	"---------

		" split line at current cursor position
		nnoremap <silent> <leader>sl i<CR><Esc>
		" reflow lines - split after join line
		" - result in the second line being formatted 
		"   accordingly in terms of comment and indentation.
		nnoremap <silent> <leader>rf Ji<CR><Esc>
		" insert new line without insert mode
		nnoremap <silent> <leader>nl O<Esc>
		" draw ascii box around the line using toilet
		nmap <silent> <leader>ab :.!toilet -f term -F border<CR> 
		nmap <silent> <leader>as :.!toilet -f future<CR> 
		nmap <silent> <leader>al :.!toilet -f mono9<CR> 
		" clear all trailing spaces
		nnoremap <silent> <leader>cts :%s/\s\+$//e<CR>

	"}}}

	" system {{{
	"-----------

		" reload .vimrc,
		" added :noh at the back to turn off prev search highlight
		" also add :set fo again becos setnocompatible will reset it to default
		nnoremap <silent> <leader>re :so $HOME/.vimrc<CR>:noh<CR>:set fo+=qcbjtro<CR>
		" remap escape key for all three modes
		cnoremap <leader>, <Esc>
		inoremap <leader>, <Esc>
		vnoremap <leader>, <Esc>

	"}}}

	" External Utilities {{{
	"-----------------------

		" use FIGlet to make a banner with current line
		nnoremap <silent> <leader>o8 :FIGlet -w 80 -c -f o8<CR>
		" call Presenting.vim to start presenting md file 
		nnoremap <silent> <leader>ps :PresentingStart<CR>
	
	"}}}



	" sessions {{{
	"-------------

		" session make - save a session
		nnoremap <leader>sema :mksession! ~/.vim/session/manual.vim<CR>
		" session load - load a previously saved session
		nnoremap <leader>selo :source ~/.vim/session/manual.vim<CR>
		" save session before exit, and reload at starting vim
		autocmd VimLeave * mksession! ~/.vim/session/shutdown.vim
		" uncomment the following line if want auto load shutdown session
		" autocmd VimEnter source ~/.vim/session/shutdown.vim<CR>
		" session reload - manual reload the previos session
		noremap <leader>sere :source ~/.vim/session/shutdown.vim<CR>

	"}}}

	" quickfix {{{
	"-------------

		" next qucikfix item
		nnoremap <leader>qn :cn<CR>
		" previous qucikfix item
		nnoremap <leader>qp :cp<CR>
		" open the qucikfix window if error, else close it
		nnoremap <leader>qw :cw<CR>

	"}}}


