#!/bin/zsh

#
# Vim Plug manager provide an option to conditional load plugin
# based on filetype detected. But for some reason, it is expecting
# the plugin directory consists of a subdirectory named 'plugin'.
# As a quick bypass, this shell script will create a symlink to
# where the plugin vim file is, as 'plugin', as such when we update
# the plugin files this should hopefully still work, unless the
# new version change the directory structure completely.
#

cd $HOME/.vim/plugged


# for python

cd indentpython.vim
ln -sf indent plugin
cd -

# for php

cd php-documentor-vim
ln -sf ftplugin plugin
cd -

cd php-indenting-for-vim
ln -sf indent plugin
cd -

cd phpcomplete.vim
ln -sf autoload plugin
cd -



