#!/usr/bin/env zsh
#
# PATH construction. Sourced twice, on purpose:
#   .zshenv  - so non-interactive/non-login zsh (scripts, `zsh -c`, editor
#              subprocesses) can find our tools at all.
#   .zprofile - to re-assert order, because macOS's /etc/zprofile runs
#              `path_helper`, which rebuilds PATH with the system paths first
#              and shoves everything we prepended behind them.
#
# `typeset -U path` (set in .zshenv) makes the second pass idempotent: a
# re-prepend moves an entry to the front instead of duplicating it.
#
# Deliberately fork-free -- no `brew shellenv`, no `brew --prefix`. This file
# runs on every single zsh invocation, so a subshell here is a tax on all of
# them. `brew shellenv` also calls `path_helper` itself, which would undo the
# ordering we just set up.

# --- homebrew (static; `brew shellenv` without the two forks) --------------
if [[ -x /opt/homebrew/bin/brew ]]; then
  export HOMEBREW_PREFIX="/opt/homebrew"        # arm64 macos
elif [[ -x /usr/local/bin/brew ]]; then
  export HOMEBREW_PREFIX="/usr/local"           # intel macos
elif [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
elif [[ -x $HOME/.linuxbrew/bin/brew ]]; then
  export HOMEBREW_PREFIX="$HOME/.linuxbrew"
fi

if [[ -n $HOMEBREW_PREFIX ]]; then
  export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar"
  export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX"
  export INFOPATH="$HOMEBREW_PREFIX/share/info${INFOPATH:+:$INFOPATH}"
  path=("$HOMEBREW_PREFIX/bin" "$HOMEBREW_PREFIX/sbin" $path)
fi

# --- ours ------------------------------------------------------------------
# Listed low-priority first: each prepend beats the one above it.
path=("/usr/local/bin" $path)
path=("$HOME/.local/bin" $path)
path=("$DOTFILES/sd" $path)
path=("$DOTFILES/scripts" $path)

# mise shims, so non-interactive shells resolve managed tools; interactive
# shells additionally get hook-based activation in .zshrc.
path=("$HOME/.local/share/mise/shims" $path)

export BUN_INSTALL="$HOME/.bun"
path=("$BUN_INSTALL/bin" $path)

path+=("$HOME/go/bin")
path+=("$HOME/.docker/bin")

[[ $OSTYPE == linux* ]] && path+=("/opt/nvim-linux64/bin")

return 0
