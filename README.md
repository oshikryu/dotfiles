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
brew install zsh
brew install python3
brew install git
brew install tmux
brew install cmake
brew install fzf
brew install ripgrep
brew install bat
brew install neovim
brew install pre-commit
brew install reattach-user-to-namespace
brew install direnv
brew install go
brew install coursier
brew install node
brew install yarn
brew install zsh-history-substring-search
```

Clone repo:

```
git clone git@github.com:oshikryu/dotfiles.git ~/.dot
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

## Neovim

Neovim plugins are managed by [lazy.nvim](https://github.com/folke/lazy.nvim) and configured in `init.lua`.
Plugins install automatically on first launch.

To update plugins, run `:Lazy update` inside Neovim.

### LSP

Language servers need to be installed separately:

```
npm install -g typescript typescript-language-server
npm install -g pyright
```

### Optional

```
yarn global add prettier
```

Add env-specific environment variables in `env.local`
Note, these are sensitive things so ensure that it is not checked in to git

```
touch ~/.env.local
```

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

## Specific profile
Create a `domino-profile.osx` to include sensitive creds and mappings that should not be committed


## Common problems

TMUX
https://superuser.com/questions/397076/tmux-exits-with-exited-on-mac-os-x
brew install reattach-to-user-namespace

zsh theme not updating
- make sure zshrc is properly symlinked
