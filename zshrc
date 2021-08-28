# ~/.zshrc

# environment variables
export PATH=$HOME/bin:$HOME/bin/scripts:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export DOTFILES="$HOME/dotfiles"
export EDITOR=code
export SFDX_DIR=$HOME/sfdx
export RESILIO_DIR="${HOME}/sync"

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
. $DOTFILES/zsh/functions
. $DOTFILES/zsh/plugins

setopt HIST_IGNORE_SPACE
HISTFILE=~/.zsh_history
HIST_STAMPS="yyyy-mm-dd"

#### asdf
. $HOME/.asdf/asdf.sh
# set JAVA_HOME
. ~/.asdf/plugins/java/set-java-home.zsh
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit


# Include local settings
[[ -f ~/.zshrc.local ]] && . ~/.zshrc.local

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
