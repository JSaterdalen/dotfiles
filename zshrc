# ~/.zshrc

# environment variables
export PATH=$HOME/bin:$HOME/bin/scripts:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/snap/bin
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export DOTFILES="$HOME/dotfiles"
export EDITOR=code
export SFDX_DIR=$HOME/sfdx
export RESILIO_DIR="${HOME}/sync"

# Mac CPU
if [[ "$OSTYPE" == "darwin"* ]]; then
  HOST_NAME=$(scutil --get HostName)
  export HOST_NAME
  
  CPU=$(uname -p)
  if [[ "$CPU" == "arm" ]]; then
      export PATH="/opt/homebrew/bin:$PATH"
  else
      export PATH="/usr/local/bin:$PATH"
  fi
fi

case "$OSTYPE" in
  darwin*)
    # ...
  ;;
  linux*)
    SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
  ;;
  *)
    # ...
  ;;
esac

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# home video project
export RAW_VIDEOS_DIR="${HOME}/home-video/videos-raw"
export PROCESSED_CLIPS_DIR="${HOME}/home-video/videos-processed"
export MEDIAGOBLIN_METADATA="${HOME}/home-video/mediagoblin-meta"
export SCENES_CSV="${MEDIAGOBLIN_METADATA}/scenes.csv"
export SCENES_YAML="${MEDIAGOBLIN_METADATA}/scenes.yaml"
export CSV_URL="https://docs.google.com/spreadsheets/d/1JKp6YT5-dIFD9aIqZhU1Tp-mi-trNCGGE97xakWXDUY/export?format=csv&id=1JKp6YT5-dIFD9aIqZhU1Tp-mi-trNCGGE97xakWXDUY&gid=401061703"

. $DOTFILES/zsh/oh-my-zsh # TODO replace omz with manual config
. $DOTFILES/zsh/aliases
. $DOTFILES/zsh/named_dir
. $DOTFILES/zsh/functions
. $DOTFILES/zsh/plugins

setopt HIST_IGNORE_SPACE
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=$HISTSIZE
HIST_STAMPS="yyyy-mm-dd"

#### asdf
. $HOME/.asdf/asdf.sh
# set JAVA_HOME
. ~/.asdf/plugins/java/set-java-home.zsh
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)

if command -v sfdx &> /dev/null; then
  # sfdx completions
  eval $(sfdx autocomplete:script zsh)
fi

if command -v sf &> /dev/null; then
  # sfdx completions
  eval $(sf autocomplete:script zsh)
fi

# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

# Color LS tab completion
source $(dirname $(gem which colorls))/tab_complete.sh

# Include local settings
[[ -f ~/.zshrc.local ]] && . ~/.zshrc.local

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh