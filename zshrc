# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# environment variables
export ZSH="$HOME/.oh-my-zsh"
export EDITOR=code
export SFDIR=$HOME/sfdx
export PATH=$HOME/bin:$HOME/bin/scripts:/usr/local/bin:/usr/local/sbin:$PATH

# home video project
export RAW_VIDEOS_DIR="${HOME}/home-video/videos-raw"
export PROCESSED_CLIPS_DIR="${HOME}/home-video/videos-processed"
export MEDIAGOBLIN_METADATA="${HOME}/home-video/mediagoblin-meta"
export SCENES_CSV="${MEDIAGOBLIN_METADATA}/scenes.csv"
export SCENES_YAML="${MEDIAGOBLIN_METADATA}/scenes.yaml"
export CSV_URL="https://docs.google.com/spreadsheets/d/1JKp6YT5-dIFD9aIqZhU1Tp-mi-trNCGGE97xakWXDUY/export?format=csv&id=1JKp6YT5-dIFD9aIqZhU1Tp-mi-trNCGGE97xakWXDUY&gid=401061703"

# pyenv
eval "$(pyenv init -)"
# node version manager
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# theme - see https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(
  git
#   npm
#   sdk
  sfdx
  zsh-autosuggestions
  zsh-syntax-highlighting
  z
  )
source $ZSH/oh-my-zsh.sh
setopt HIST_IGNORE_SPACE

source $HOME/.zsh_aliases

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
