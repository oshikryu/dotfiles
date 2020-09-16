# Dotfiles

## Pre-Installation

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

```
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_rsaOpen your ~/.ssh/config file, then modify the file, replacing ~/.ssh/id_rsa if you are not using the default location and name for your id_rsa key.
```

## Installation

1. Install git:

    ```
    git clone git@github.com:oshikryu/dotfiles.git ~/.dot
    cd ~/.dot
    git submodule update --init --recursive
    ```

2. Install zsh (on Debian):

    ```
    sudo apt-get update
    sudo apt-get install zsh
    ```

3. Install zsh (on osx):

    ```
    brew update
    brew install zsh
    ```

4. Change to zsh:

    ```
    chsh -s /bin/zsh
    ```

5. Create symlinks by editing and run the `init_osx` or `init_debian` script.


6. Install vim-plug:
    ```
     curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ```

    Follow this up by running `:PlugInstall` in vim.

7. (Linux) Be sure that vim is built with python

    ```
    sudo apt-get install vim-nox
    ```


8. (Linux) Be sure you have build tools

    ```
    sudo apt-get install build-essential cmake
    sudo apt-get install python2.7-dev
    ```

9. Be sure you have build tools (on OSX)

    ```brew install cmake```

10. (Optional) Install YouCompleteMe:

    ```
    cd ~/.vim/plugged/YouCompleteMe
    git submodule update --init --recursive
    ./install.py
    ```

11. (Optional) Install prettier

    ```
    yarn global add prettier
    ```

12. Installing fzf

I changed the fuzzy finding library from ctrlp because that was way slow. Install fzf via brew or
change the vimrc to install via vim-plug

    ```
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    ```

## Updating submodules
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
