#!/bin/sh
# Claude Code status line for tmux
# Mirrors the zshrc prompt: host:dir [venv] branch✓/✗ + model + context

input=$(cat)

# Claude info
model=$(echo "$input" | jq -r '.model.display_name // empty')
cwd=$(echo "$input" | jq -r '.workspace.current_dir // empty')
remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')

# Git branch + dirty status (skip optional locks)
branch=""
if [ -n "$cwd" ] && git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null)
    if [ -n "$branch" ]; then
        if [ -n "$(git -C "$cwd" status --porcelain 2>/dev/null)" ]; then
            branch="${branch}✗"
        else
            branch="${branch}✓"
        fi
    fi
fi

# Build the line
line=""

# host:dir
if [ -n "$cwd" ]; then
    host=$(hostname -s)
    dir=$(basename "$cwd")
    line="${host}:${dir}"
fi

# git branch
if [ -n "$branch" ]; then
    line="${line} ${branch}"
fi

# model
if [ -n "$model" ]; then
    line="${line} | ${model}"
fi

# context remaining
if [ -n "$remaining" ]; then
    printf "%.0f" "$remaining" > /dev/null 2>&1 && \
        line="${line} ctx:$(printf '%.0f' "$remaining")%"
fi

echo "$line"
