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

Install development tools
```
sudo yum group install "Development Tools" -y
sudo yum install man-pages -y
gcc --version
```

Install related brew libraries
```
brew update
brew install gcc@8
brew install zsh
brew install python3
brew install git
brew install tmux
brew install cmake
brew install fzf
brew install ripgrep
brew install bat
brew install neovim
```

Remove vim deps

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
sudo yum install zsh -y
```

Change to zsh:

```
sudo chsh -s /bin/zsh ec2-user
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

