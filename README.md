## Installation (OSX)

### 1. Install Homebrew

```
# install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# uninstall (if needed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
```

### 2. Clone repo

```
git clone git@github.com:oshikryu/dotfiles.git ~/.dot
```

### 3. Run the init script

This installs brew dependencies, switches to zsh, creates symlinks, sets up neovim with lazy.nvim, and installs language servers.

```
./init_osx
```

The script will optionally prompt to install the legacy vim-plug config.

## Neovim

Plugins are managed by [lazy.nvim](https://github.com/folke/lazy.nvim) and configured in `init.lua`. Plugins install automatically on first launch.

- Update plugins: `:Lazy update`
- Sync plugins: `:Lazy sync`

### LSP

Language servers are installed by the init script via yarn:

```
yarn global add typescript typescript-language-server pyright prettier
```

## Rust

Rust is installed via `rustup` by the init script. The cargo bin path (`~/.cargo/bin`) is already in `PATH` via `zshrc`.

To update Rust later:
```
rustup update
```

## Environment variables

Add env-specific or sensitive variables in `~/.env.local` (created by the init script, not tracked by git):

```
touch ~/.env.local
```

## SSH keys

1. Generate a key and add to the SSH agent:
```
ssh-keygen -t rsa -b 4096
ssh-add ~/.ssh/id_rsa
```

2. Copy `~/.ssh/id_rsa.pub` and add to GitHub: https://docs.github.com/en/authentication/connecting-to-github-with-ssh

3. For OSX 10.12+, add to `~/.ssh/config`:
```
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_rsa
```

## Git

The `gitconfig` is symlinked and shared across machines (default email: `ryushikiri@gmail.com`).

For machine-specific overrides (e.g. a work email or a different `core.excludesfile`), edit `~/.dot/gitconfig.local` — it's created by the init script, gitignored, and automatically included by `gitconfig`:

```
[user]
	email = you@work-example.com
[core]
	excludesfile = ~/.dot/.gitexclude.work
```

## Claude Code settings

`~/.claude/settings.json` is a one-time copy of `claude/settings.json` (not a live symlink), so local edits — like the model picked via `/model` — stay on that machine instead of leaking into the tracked file. To pick up changes made to the tracked `claude/settings.json` on an existing machine, copy it over manually:

```
cp ~/.dot/claude/settings.json ~/.claude/settings.json
```

## Troubleshooting

### tmux exits immediately on launch
```
brew install reattach-to-user-namespace
```
See: https://superuser.com/questions/397076/tmux-exits-with-exited-on-mac-os-x

### zsh theme not updating
Make sure `~/.zshrc` is properly symlinked to `~/.dot/zshrc`.

### colorscheme not found (legacy vim-plug only)
```
cp -r colors ~/.vim/
```
