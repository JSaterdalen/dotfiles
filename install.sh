#!/usr/bin/env bash

################################################################################
# install
#
# This script symlinks dotfiles into place in the home and config directories
################################################################################

dotfiles_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\\n[DOTFILES] ${fmt}\\n" "$@"
}

dotfiles_backup() {
  if ! command -v gcp >/dev/null || ! command -v gdate >/dev/null; then
    dotfiles_echo "GNU cp and date commands are required. Please install via Homebrew coreutils: brew install coreutils"
    exit 1
  elif [ -d "$1" ]; then
    mv -v "$1" "${1}_bak_$(gdate +"%Y%m%d%3N")"
  else
    gcp -f --backup=numbered "$1" "$1"
  fi
}

set -e # Terminate script if anything exits with a non-zero value

if [ -z "$DOTFILES" ]; then
  export DOTFILES="${HOME}/dotfiles"
fi

if [ -z "$HOST_NAME" ]; then
  HOST_NAME=$(scutil --get HostName)
  export HOST_NAME
fi

if [ ! -d "${DOTFILES}/machines/${HOST_NAME}" ]; then
  mkdir "${DOTFILES}/machines/${HOST_NAME}"
  cp "$DOTFILES"/machines/default-mac/* "${DOTFILES}/machines/${HOST_NAME}/"
fi

if [ -z "$XDG_CONFIG_HOME" ]; then
  if [ ! -d "${HOME}/.config" ]; then
    mkdir "${HOME}/.config"
  fi
  export XDG_CONFIG_HOME="${HOME}/.config"
fi

home_files=(
# "asdfrc"
# "default-npm-packages"
"gitconfig"
"gitignore_global"
"p10k.zsh"
"tool-versions"
"zshrc"
)

config_dirs=(
)

config_files=(
)

dotfiles_echo "Installing dotfiles..."

dotfiles_echo "-> Linking basic dotfiles..."
for item in "${home_files[@]}"; do
  if [ -e "${HOME}/.${item}" ]; then
    dotfiles_echo ".${item} exists."
    if [ -L "${HOME}/.${item}" ]; then
      dotfiles_echo "Symbolic link detected. Removing..."
      rm -v "${HOME}/.${item}"
    else
      dotfiles_echo "Backing up..."
      dotfiles_backup "${HOME}/.${item}"
    fi
  fi
  dotfiles_echo "-> Linking ${DOTFILES}/${item} to ${HOME}/.${item}..."
  ln -nfs "${DOTFILES}/${item}" "${HOME}/.${item}"
done

# TODO symlink ~/bin files

dotfiles_echo "-> Linking Brewfile..."
if [ -e "${HOME}/Brewfile" ]; then
  dotfiles_echo "Brewfile exists."
  if [ -L "${HOME}/Brewfile" ]; then
    dotfiles_echo "Symbolic link detected. Removing..."
    rm -v "${HOME}/Brewfile"
  else
    dotfiles_echo "Backing up..."
    dotfiles_backup "${HOME}/Brewfile"
  fi
fi
dotfiles_echo "-> Linking ${DOTFILES}/Brewfile to ${HOME}/Brewfile..."
ln -nfs "${DOTFILES}/Brewfile" "${HOME}/Brewfile"

# TODO append machine specific brewfile to base file

# dotfiles_echo "-> Linking config directories..."
# for item in "${config_dirs[@]}"; do
#   if [ -d "${XDG_CONFIG_HOME}/${item}" ]; then
#     dotfiles_echo "Directory ${item} exists."
#     if [ -L "${XDG_CONFIG_HOME}/${item}" ]; then
#       dotfiles_echo "Symbolic link detected. Removing..."
#       rm -v "${XDG_CONFIG_HOME}/${item}"
#     else
#       dotfiles_echo "Backing up..."
#       dotfiles_backup "${XDG_CONFIG_HOME}/${item}"
#     fi
#   fi
#   dotfiles_echo "-> Linking ${DOTFILES}/${item} to ${XDG_CONFIG_HOME}/${item}..."
#   ln -nfs "${DOTFILES}/${item}" "${XDG_CONFIG_HOME}/${item}"
# done

# dotfiles_echo "-> Linking config files..."
# for item in "${config_files[@]}"; do
#   if [ -e "${XDG_CONFIG_HOME}/${item}" ]; then
#     dotfiles_echo "${item} exists."
#     if [ -L "${XDG_CONFIG_HOME}/${item}" ]; then
#       dotfiles_echo "Symbolic link detected. Removing..."
#       rm -v "${XDG_CONFIG_HOME}/${item}"
#     else
#       dotfiles_echo "Backing up..."
#       dotfiles_backup "${XDG_CONFIG_HOME}/${item}"
#     fi
#   fi
#   dotfiles_echo "-> Linking ${DOTFILES}/machines/${HOST_NAME}/${item} to ${XDG_CONFIG_HOME}/${item}..."
#   ln -nfs "${DOTFILES}/machines/${HOST_NAME}/${item}" "${XDG_CONFIG_HOME}/$item"
# done

dotfiles_echo "Dotfiles installation complete!"

dotfiles_echo "Post-install recommendations:"
dotfiles_echo "- Complete Brew Bundle installation with 'brew bundle install'"
