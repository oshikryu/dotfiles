## Installation (linux)
Install brew
```
brew update
brew install python3
brew install git
brew install zsh
brew install tmux
brew install reattach-user-namespace
brew install cmake
brew install fzf
```

Clone repo and dependencies
```
git clone git@github.com:oshikryu/dotfiles.git ~/.dot
cd ~/.dot
git submodule update --init --recursive
```


For amazon-linux, substitute `yum` for `apt-get`

Install zsh (on Debian):

```
sudo yum update
sudo yum install zsh
```

Change to zsh:

```
chsh -s /bin/zsh
```

Create symlinks by editing and run the `init_debian` script.
```
./init_debian
```


(Linux) Be sure that vim is built with python

```
sudo apt-get install vim-nox
```


(Linux) Be sure you have build tools

```
sudo apt-get install build-essential cmake
sudo apt-get install python2.7-dev
```

Youcompleteme
```
cd ~/.vim/plugged/YouCompleteMe
git submodule update --init --recursive
./install.py
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
  
  or 
```
brew install gcc@8
brew link gcc@8
./install.py
```
  
### zshrc for amazon-linux
Remove or comment out this line
```
# ask for ssh key password only the first time you boot up
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l | grep "The agent has no identities" && ssh-add
```

