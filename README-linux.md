## Installation (Linux)

### 1. Install Homebrew

```
# install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
echo 'eval "$(/home/ec2-user/.linuxbrew/bin/brew shellenv)"' >> /home/ec2-user/.bash_profile
eval "$(/home/ec2-user/.linuxbrew/bin/brew shellenv)"

# uninstall (if needed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
```

### 2. Install development tools

```
sudo yum group install "Development Tools" -y
sudo yum install man-pages -y
```

### 3. Clone repo

```
git clone git@github.com:oshikryu/dotfiles.git ~/.dot
```

### 4. Run the init script

This installs brew and yum dependencies, switches to zsh, creates symlinks, and sets up neovim with lazy.nvim.

```
./init_debian
```

The script will optionally prompt to install the legacy vim-plug config.

For Amazon Linux, substitute `yum` for `apt-get`.

## Neovim

Plugins are managed by [lazy.nvim](https://github.com/folke/lazy.nvim) and configured in `init.lua`. Plugins install automatically on first launch.

- Update plugins: `:Lazy update`
- Sync plugins: `:Lazy sync`

## Git

The `gitconfig` is symlinked and shared across machines.

For machine-specific overrides (e.g. a work email or a different `core.excludesfile`), edit `~/.dot/gitconfig.local` — it's created by the init script, gitignored, and automatically included by `gitconfig`:

```
[user]
	email = you@work-example.com
[core]
	excludesfile = ~/.dot/.gitexclude.work
```

Verify with `git config --list`.

## Claude Code settings

`~/.claude/settings.json` is a one-time copy of `claude/settings.json` (not a live symlink), so local edits — like the model picked via `/model` — stay on that machine instead of leaking into the tracked file. To pick up changes made to the tracked `claude/settings.json` on an existing machine, copy it over manually:

```
cp ~/.dot/claude/settings.json ~/.claude/settings.json
```

## Troubleshooting

### fzf: `fzf#run function not found`

Ensure fzf is installed via brew and the fzf plugin is loaded in `init.lua`. With lazy.nvim, fzf is declared as a plugin dependency and should work automatically.

See: https://github.com/junegunn/fzf.vim/issues/439

### colorscheme not found (legacy vim-plug only)

```
cp -r colors ~/.vim/
```

### zsh SSH agent issues on Amazon Linux

If you get SSH agent errors, remove or comment out the SSH agent block in `zshrc`:

```
# ask for ssh key password only the first time you boot up
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l | grep "The agent has no identities" && ssh-add
```
