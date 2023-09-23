# Install Latest/Desired Python on Pi OS Lite

## Install/Update the necessary libraries to compile Python from source
  ```
    sudo apt update && sudo apt upgrade
    sudo apt install build-essential checkinstall 
    sudo apt install libreadline-gplv2-dev libncursesw5-dev libssl-dev
    sudo apt install libsqlite3-dev tk-dev libgdbm-dev 
    sudo apt install libc6-dev libbz2-dev zlib1g-dev xz-utils 
    sudo apt install libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
  ```

## Install Git
  ```
    sudo apt install git
  ```

## Download Python version manager Pyenv from github
  ```
    cd
    mkdir src
    cd src 
    git clone https://github.com/pyenv/pyenv.git
  ```

## Download and compile Python
  ```
    pyenv install 3.11.5 <- or any other desired version
  ```
  This will install Python into the ~/.pyenv directory. 
  Next, open the shell rc file in an editor and append the following at the bottom:
  ```
    export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
  ```
  *The above comes from*
  ```
    pyenv init
  ```
  *so, if need be, run the command for any updates*
