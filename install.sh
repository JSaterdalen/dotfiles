#!/usr/bin/env bash

dotfiles_echo() {
  local fmt="$1"; shift

  printf "\\n[DOTFILES] ${fmt}\\n" "$@"
}

set -e # Terminate script if anything exits with a non-zero value

if [ -z "$DOTFILES" ]; then
  export DOTFILES="${HOME}/dotfiles"
fi

HOME_FILES=(
  'zshrc'
  'zsh_aliases'
  'zprofile'
  'profile'
  'p10k.zsh'
)

SCRIPTS_PATH='~/scripts'
BIN_PATH='~/bin'

dotfiles_echo "Installing dotfiles..."

dotfiles_echo "-> Linking basic dotfiles..."
for item in "${HOME_FILES[@]}"; do
  if [ -e "${HOME}/.${item}" ]; then
    dotfiles_echo ".${item} exists."
    if [ -L "${HOME}/.${item}" ]; then
      dotfiles_echo "Symbolic link detected. Removing..."
      rm -v "${HOME}/.${item}"
    # else
    #   dotfiles_echo "Backing up..."
    #   dotfiles_backup "${HOME}/.${item}"
    fi
  fi
  dotfiles_echo "-> Linking ${DOTFILES}/${item} to ${HOME}/.${item}..."
  ln -nfs "${DOTFILES}/${item}" "${HOME}/.${item}"
done