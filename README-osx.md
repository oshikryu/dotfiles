# Dotfiles

## SSH keys

1. Create ssh keys and add to github https://help.github.com/articles/generating-ssh-keys/
```
ls -al ~/.ssh
ssh-keygen -t rsa -b 4096
<enter>
<enter>
<enter>
ssh-add ~/.ssh/id_rsa
```
2. Copy id_rsa.pub

3. For OSX 10.12 > you need to add your SSH key to the SSH agent
https://docs.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent

4. (If no config file) `touch ~/.ssh/config`
5. Open your ~/.ssh/config file, then modify the file, replacing ~/.ssh/id_rsa if you are not using the default location and name for your id_rsa key.

>
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_rsaOpen your ~/.ssh/config file, then modify the file, replacing ~/.ssh/id_rsa if you are not using the default location and name for your id_rsa key.

## Git
Since the `gitconfig` is symlinked, update the email to match the proper system usage

```
git config --global user.email "ryushikiri@gmail.com"
```

## Installation (OSX)
Install brew
```
# brew uninstall
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"

# brew install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

Install related brew libraries
Be sure you have build tools (on OSX)
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
brew install reattach-to-user-namespace
brew install ripgrep
brew install bat
```

Clone repo and git dependencies:

```
git clone git@github.com:oshikryu/dotfiles.git ~/.dot
cd ~/.dot
git submodule update --init --recursive
```

Change to zsh:

```
chsh -s /bin/zsh
```

Create symlinks by editing and run the `init_osx`

```
./init_osx
```

Your shell zsh theme should change

## Vim dependencies
Install vim-plug:

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Follow this up by running `:PlugInstall` in vim.

```
vim +'PlugInstall --sync' +qa
```

(Optional) Install YouCompleteMe:

NOTE: this requires python libraries
```
cd ~/.vim/plugged/YouCompleteMe
git submodule update --init --recursive
./install.py
```

(Optional) Install prettier

```
yarn global add prettier
```

Installing fzf

I changed the fuzzy finding library from ctrlp because that was way slow. Install fzf via brew or
change the vimrc to install via vim-plug

```
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
```

To use in-file search via Ag
```
:FzfAg
```

### Updating submodules
```
vim :PlugUpdate or vim :PlugInstall!
```


## Common problems
http://unix.stackexchange.com/questions/27851/after-installing-oh-my-zsh-zshrcsource34-no-such-file-or-directory

no submodule mapping
http://stackoverflow.com/questions/4185365/no-submodule-mapping-found-in-gitmodule-for-a-path-thats-not-a-submodule

Autoindent is not working:
:set indentexpr=
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

Updating osx version needs to have compatible brew macvim

TMUX
https://superuser.com/questions/397076/tmux-exits-with-exited-on-mac-os-x
brew install reattach-to-user-namespace

backup/swap files:
Getting the must overwrite and no backup? link the proper dir and chmod
`sudo chmod 0750 ~/.vim/vim/tmp/swap`
`sudo chmod 0750 ~/.vim/vim/tmp/backup`


python error when installing YCM
https://stackoverflow.com/questions/62546912/youcompleteme-completed-failed
ERROR: Python headers are missing in /Applications/Xcode.app/Contents/Developer/Library/Frameworks/Python3.framework/Versions/3.8/Headers.
/usr/local/bin/python3.9 install.py --all

install go https://github.com/ycm-core/YouCompleteMe/issues/3074

zshell theme not updating
- make sure zshrc is properly symlinked
