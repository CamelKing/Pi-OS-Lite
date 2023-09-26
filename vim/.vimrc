" The following file map the <leader> key
" It has to be the first line in .vimrc
" because some of the plugins will map keys 
" using <leader>
	source $HOME/.vim/config/vim/mapleader-config.vim

" Load Plugin
"============
	source $HOME/.vim/config/plugins/load-plugins.vim

" Setup Plugins {{{
"==================

	" python related config files loaded by ftplugin/python.vim

	" typescript config files loaded by ftplugin/typescript.vim
	" and ftplugin/typescriptreact.vim

	" php config files loaded by ftplugin/php.vim {{{
	"--------

		" source $HOME/.vim/config/plugins/php-documentor-config.vim
		" source $HOME/.vim/config/plugins/phpcomplete-config.vim
		" source $HOME/.vim/config/plugins/php-indent-config.vim
		" source $HOME/.vim/config/plugins/php-vim-config.vim

	" }}}

	" html/css {{{
	"-------------
		source $HOME/.vim/config/plugins/emmet-config.vim

	" }}}

	" Version control plugins settings {{{
	"-------------------------------------
		source $HOME/.vim/config/plugins/signify-config.vim

	" }}}

	" Baisc plugins settings - not language related {{{
	"--------------------------------------------------

		" display colors based on color codes
		source $HOME/.vim/config/plugins/colorizer-config.vim
		" statuslines configuration
		source $HOME/.vim/config/plugins/airlines-config.vim

		" file and directory
		source $HOME/.vim/config/plugins/nerdtree-config.vim
		source $HOME/.vim/config/plugins/ctrlp-config.vim
		source $HOME/.vim/config/plugins/vim-ripgrep-config.vim

		" editing
		source $HOME/.vim/config/plugins/nerdcommenter-config.vim

	" }}}

	" Unused basic plugins {{{
	"-------------------------

		" source $HOME/.vim/config/plugins/autotag-config.vim
		" source $HOME/.vim/config/plugins/ultisnip-config.vim

	" }}}

"  }}}

" Setup Vim {{{
"==============

	" general settings for vim
	source $HOME/.vim/config/vim/general-config.vim
	" general key mapping for vim
	source $HOME/.vim/config/vim/keymap-config.vim
	" misc pathces - MUST put as last item on vimrc
	source $HOME/.vim/config/vim/patch-config.vim

" }}}


