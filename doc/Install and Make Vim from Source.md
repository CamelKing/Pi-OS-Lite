
1. Download the source and make vim.

```
# git clone https://github.com/vim/vim.git
# cd vim/src
# make
# make test
# make install
# vim
```


2. If error message during make/make test:

```
      checking for tgetent()... configure: error: NOT FOUND!
      You need to install a terminal library; for example ncurses.
      On Linux that would be the libncurses-dev package.
      Or specify the name of the library with --with-tlib.
```

then install ncurses library and libtool by:

```
sudo apt install libncurses5-dev libncursesw5-dev
sudo apt install libtool libtool-bin
```
