## Installation (linux)

Install zsh (on Debian):

```
sudo apt-get update
sudo apt-get install zsh
```

Change to zsh:

```
chsh -s /bin/zsh
```

Create symlinks by editing and run the `init_debian` script.


(Linux) Be sure that vim is built with python

```
sudo apt-get install vim-nox
```


(Linux) Be sure you have build tools

```
sudo apt-get install build-essential cmake
sudo apt-get install python2.7-dev
```

## Debugging
### fzf
E605: Exception not caught: fzf#run function not found. You also need Vim plugin from the main fzf repository (i.e. junegunn/fzf *and* junegunn/fzf.vim)
Error detected while processing function <SNR>67_history:

https://github.com/junegunn/fzf.vim/issues/439

Need to get the correct path to fzf in vimrc
```
  Plug 'junegunn/fzf', { 'dir': '~/opt/fzf' }
```

### colorscheme not found
```
  cp -r colors ~/.vim/
```

### YcmServer

https://ops.tips/gists/navigating-the-linux-kernel-source-with-youcompleteme/
```
sudo yum install gcc-c++ ncurses-devel python-devel cmake

  
CC=gcc-8 CXX=g++-8 python3 ./install.py
```

