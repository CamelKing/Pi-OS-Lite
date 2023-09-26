
" General settings for Vim
"=========================

	" plugin {{{
	"-----------

		filetype plugin on		" enable loading of plugin by filetype 

	"}}}

	" indentation {{{
	"----------------

		filetype indent on		" indendation by file type
		set autoindent				" auto indent next line
		set background="dark"	" default to dark background
		set smartindent				" Indent in smart fashion
		set shiftround				" round the indentation when shifting lines
		set shiftwidth=2			" indentation is 4 columns
		set tabstop=2					" a tab will be represented with 4 columns
		set softtabstop=2			" <tab> is pressed in insert mode 4 columns
		set noexpandtab				" tabs are tabs, do not replace with spaces

	"}}}

	" search {{{
	"-----------

		set incsearch		" set highlight while typing search term
		set hlsearch		" set highlight for found search item
		set ignorecase	" default case insensitive search
		set smartcase		" case sensitive search if there is cap in search term

	"}}}

	" text rendering {{{
	"-------------------

		syntax enable					" highlight syntax
		set encoding=utf-8		" support unicode
		set display+=lastline	" display last line when possible
		if has('nvim')
			set display+=msgsep		" scroll message lines not entire screen
		endif
		set linebreak					" avoid breaking a word when wrapping
		set scrolloff=2				" number of lines above and below cursor
		set sidescrolloff=5		" number of columns left and right cursor
		set wrap							" enable line wrapping
		set breakindent				" indent after line wrapping
		set showbreak=>>>			" append >>> at wrapped line
		set nolist						" default to not display hidden characters in file
		" control what char is displayed for hidden char
		set listchars=eol:¥,tab:··¦,trail:░,extends:▶,precedes:◀
		" set backspace=indent,eol,start:
		set backspace=2				" always backspace
		set autoread					" auto read file if changed by other program
		" set the format options for filetype, and
		" also when entering buffer (in case plugins
		" are changing the format options). Lastly
		" also add in :set fo at the reload key mapping
		" as set nocompaitble during reload will reset fo
		" to default value of tcq.
		" +=j	delete comment char when joining lines
		" +=t	auto wrap text using textwidth
		" +=r	auto insert the comment leader after hitting enter
		" +=c	auto-wrap comments using textwidth, inserting the comment leader
		" +=b	auto-wrap only at new line or before textwidth
		" +=o	do not add comment when opening new line
		autocmd BufEnter * set formatoptions+=qcbjtro 
		autocmd FileType * set formatoptions+=qcbjtro 

	"}}}

	" user interface {{{
	"-------------------

		set number								" show line number
		set relativenumber				" show relative line numbers
		set ruler									" show the cursor position all the time
		augroup numbertoggle			" auto toggle hybrid and abs line number 
		  autocmd!
		  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
		  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
		augroup END
		set wildmenu							" use wild menu for command completion
		set wildmode=list:longest	" match the longest when more than one option
		set noerrorbells					" disable beep when error
		set novisualbell					" disable screen flashing when error
		set showcmd								" show wip command in status line
		set belloff="all"					" turn off bell for all event
		set laststatus=2					" always show status line

		set cursorline						" highlight cursor line
		set cursorlineopt=both		" only highlight cursor line number
	"}}}

	" movement {{{
	"-------------

		set nostartofline			" fix cursor column when scroll (c-u, c-d, c-b, c-f)
		set whichwrap=h,l,<,>	" left/right arrow keys to wrap to prev/next line

	"}}}

	" color {{{
	"----------

		set background=dark			" indicate we'll use dark background
		colorscheme onedark			" atom one dark color scheme
		set colorcolumn=80
		" all color settings must be done after setting color scheme
															" set color for color column at 80
		highlight ColorColumn			ctermbg=236  guibg=darkgrey
															" set colro for special comment
		highlight SpecialComment  ctermfg=Cyan guifg=#80a0ff 
															" set color for active line number
		highlight CursorLineNR		ctermbg=White ctermbg=235
	"}}}

	" edit {{{

		set complete-=i				" do not scan include file for auto complete
		set nrformats=bin,hex	" number formats

	"  }}}

	" code folding {{{
	"-----------------

		" fold method should be set respectively by
		" ftplugin/filetype.vim

		" use a space as fill chars so the screen is not too messy
		set fillchars=fold:\ 	" <-- this is an escaped space
		" custom function for foldtext allows saved doc 
		" views to be refreshed with a simple reload of vimrc
		set foldtext=MyFoldText()
		function MyFoldText()
      let line = getline(v:foldstart)
      let sub = substitute(line, '/\*\|\*/\|\{\{\{\d\=', '', 'g')
      return v:folddashes . sub
    endfunction

		" commented out - autoclose fold when moving out
		" set foldclose=all		" autoclose fold when moving out

		augroup AutoSaveFolds
			" Autocmd!
			" view files are about 500 bytes
			" bufleave but not bufwinleave captures closing 2nd tab
			" nested is needed by bufwrite* (if triggered via other autocmd)
			" using ?* will avoid error when opening empty buffer
			" auto save view when exit file
			autocmd BufWinLeave,BufLeave,BufWritePost ?* nested silent! mkview!
			" auto load view when open file
			autocmd BufWinEnter ?* silent! loadview
		augroup end

	"}}}

	" backup, undo, view file and directory handling {{{
	"---------------------------------------------------

		set confirm											" confirm dialog when quit unsaved file
		" create respestive directories for various vim functions
		silent! execute "!mkdir -p $HOME/.vim/session"
		silent! execute "!mkdir -p $HOME/.vim/view"
		set viewdir=$HOME/.vim/view			" directory to store view file
		silent! execute "!mkdir -p $HOME/.vim/swap"
		set directory=$HOME/.vim/swap		" directory to store swap file
		silent! execute "!mkdir -p $HOME/.vim/backup"
		set backup											" enable backup
		set backupdir=$HOME/.vim/backup	" directory to store backup file
		silent! execute "!mkdir -p $HOME/.vim/undo"
		set undofile										" enable persistant undo history
		set undodir=$HOME/.vim/undo			" directory to store backup file
		set history=10000								" store # of undo history
		set autoread										" reread files if modified by external
		set viminfo+=n~/.vim/swap/viminfo		" set the location of the viminfo file
		if has('nvim') | let &viminfo .= '.nvim' | endif "diff file for nvim
		" routines to force trigger autoread
		if ! exists("g:CheckUpdateStarted")
			let		g:CheckUpdateStarted=1
			let NERDTreeHighlightCursorline=1
			call	timer_start(1,'CheckUpdate')
		endif
		function! CheckUpdate(timer)
			silent!	checktime
			call	timer_start(1000,'CheckUpdate')
		endfunction

	"}}}

