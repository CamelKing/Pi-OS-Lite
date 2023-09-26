
" set the vim directory as a session variable
let s:vim_dir='$HOME/.vim'

" auto install vim-plug {{{

	if empty(glob(s:vim_dir.'/autoload/plug.vim'))
		exec 'silent !curl -fLo '.s:vim_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
		redraw!
		autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif

" }}}

" running vim-plug at startup {{{

	call plug#begin(s:vim_dir.'/plugged')	" Specify a directory for plugins

		" python {{{
		"-----------

			" syntax highlighting handled by vim-polyglot
			
			" call autopep8 to format file
			Plug 'tell-k/vim-autopep8', {'for':'python'}
			" linting and fixing
			Plug 'dense-analysis/ale', {'for':'python'}
      " Jedi Vim auto complete"
      Plug 'davidhalter/jedi-vim', {'for':'python'}
			" pep8 indentation for python
			Plug 'vim-scripts/indentpython.vim'

		" }}}

		" javascript/typescript/react {{{
		"--------------------------------
		
			" syntax highlighting handled by vim-polyglot
			
		" }}}

		" php {{{
		"--------

			" syntax highlighting handled by vim-polyglot
			
			" php identation
			Plug '2072/php-indenting-for-vim', {'for':'php'}
			" auto complete for php - <c-x,c-o>
			Plug 'shawncplus/phpcomplete.vim', {'for':'php'}
			" call PhpDoc() - <,db>
			Plug 'sumpygump/php-documentor-vim', {'for':'php'}
			" Kite for vim - intellisense
			Plug 'kiteco/vim-plugin'

		" }}}

		" html/css {{{
		"-------------

			" syntax highlighting handled by vim-polyglot

			" <c-y ,> => <c-e ,>
			Plug 'mattn/emmet-vim', {'for':['html','css']}

		" }}}

		" Syntax highlight for multiple language {{{
		"-------------------------------------------

			" syntax support
			" to disable a certain language, do this before loading
			" let g:polyglot_disabled = ['css']
			Plug 'sheerun/vim-polyglot'

		" }}}

		" Version control - Git {{{
		"--------------------------------------------------

			" git tools for vim
			Plug 'tpope/vim-fugitive'
			" show changes in code vs git
			Plug 'mhinz/vim-signify'

		" }}}

		" Basic plugins - not language or tool specific {{{
		"--------------------------------------------------

			" color scheme
			" gruvbox color scheme
			Plug 'morhetz/gruvbox'
			" iceberg color scheme
			Plug 'cocopon/iceberg.vim'
			" Atom's one dark syntax theme
			Plug 'joshdick/onedark.vim'

			" display
			" colorize color code text
			Plug 'chrisbra/colorizer'
			" status bar
			Plug 'vim-airline/vim-airline'
			" status bar color - :AirlineTheme
			Plug 'vim-airline/vim-airline-themes'

			" file and directory
			" search file name - <c-p>
			Plug 'ctrlpvim/ctrlp.vim'
			" search file contents - :Rg
			Plug 'jremmen/vim-ripgrep'
			" directory tree - <,nt>
			Plug 'scrooloose/nerdtree'

			" editing
			" auto complete pairs of brackets
			" Plug 'ferranpm/vim-autopairs' <- obsolete
			Plug 'jiangmiao/auto-pairs'
			" surround verb - cs, ds, yss
			Plug 'tpope/vim-surround'
			" comment tools - <,cc>
			Plug 'scrooloose/nerdcommenter'

		" }}}

		" Vim utility plugins - {{{
		"--------------------------

			" use vim as presentation tool
			Plug 'sotte/presenting.vim'

			" integrate with figlet
			" usage: :1,10FIGlet -w 80 -f cybermedium
			Plug 'fadein/vim-figlet'

		" }}}



		" Unused basic plugins {{{
		"-------------------------

			" tags for autocomplete
			" Plug 'craigemery/vim-autotag'			" auto update ctag file when save

			" snippets
			" Plug 'sirver/ultisnips'						" snippets auto complete - tab
			" Plug 'honza/vim-snippets'					" snippets for vim

		" }}}

	call plug#end()			" Initialize plugin system

" }}}


