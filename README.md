## Installation (linux)
Install brew

```
# brew uninstall
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"

# brew install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
echo 'eval "$(/home/ec2-user/.linuxbrew/bin/brew shellenv)"' >> /home/ec2-user/.bash_profile
eval "$(/home/ec2-user/.linuxbrew/bin/brew shellenv)"
```

```
sudo yum group install "Development Tools"
sudo yum install man-pages
gcc --version
```


```
brew update
brew install gcc
brew install zsh
brew install python3
brew install git
brew install tmux
brew install cmake
brew install fzf
brew install the_silver_searcher
brew install ripgrep
brew install bat
```

Clone repo and dependencies
```
git clone git@github.com:oshikryu/dotfiles.git ~/.dot
cd ~/.dot
git submodule update --init --recursive
```

Create symlinks by editing and run the `init_debian` script.
Remove previous `.bash_profile` and `.zprofile` to apply zsh theme
```
./init_debian
```

## Vim dependencies
Install vim-plug:

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Follow this up by running `:PlugInstall` in vim.


For amazon-linux, substitute `yum` for `apt-get`

Install zsh (on Debian):

```
sudo yum update
sudo yum install zsh
```

Change to zsh:

```
sudo chsh -s /bin/zsh ec2-user
```

Youcompleteme
```
wget https://cmake.org/files/v3.24/cmake-3.24.1.tar.gz
tar -xvzf cmake-3.24.1.tar.gz
cd cmake-3.24.1
./bootstrap
sudo make
sudo make install

sudo yum install gcc-c++ ncurses-devel python-devel cmake
cd ~/.vim/plugged/YouCompleteMe
git submodule update --init --recursive

CC=gcc-8 CXX=g++-8 python3 ./install.py
```

### Git
```
git config --global user.email "ryuta.oshikiri@dominodatalab.com"
git config --list
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

