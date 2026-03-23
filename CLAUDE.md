# Dotfiles

Personal dotfiles repo for OSX and Linux (Amazon Linux/Debian) environments.

## Structure

- `init_osx` / `init_debian` — Bootstrap scripts that install deps, create symlinks, and set up neovim
- `profile.osx` / `profile.linux` — Shell aliases and environment variables (sourced via `~/.profile`)
- `zshrc` / `zprofile` — Zsh configuration
- `init.lua` — Neovim config (lazy.nvim plugin manager, LSP, treesitter, DAP, keymaps)
- `goconfig.lua` — Go-specific neovim config (loaded by init.lua)
- `tmux.osx` / `tmux.linux` — Tmux configs
- `gitconfig` / `gitignore` — Git configuration
- `vim/` / `vimrc` — Legacy vim config (optional, behind a prompt in init scripts)

## Key details

- Neovim uses **lazy.nvim** (not vim-plug). Plugins are declared in `init.lua` and auto-install on first launch.
- Leader key is `,`
- Shell aliases are in `profile.osx` and `profile.linux` — keep them in sync when adding new ones.
- Sensitive env vars go in `~/.env.local` (not tracked).
- Legacy vim-plug setup is optional in both init scripts.
