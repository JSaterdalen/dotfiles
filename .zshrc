# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# environment variables
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH
export EDITOR=code


# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# --- aliases --- #
alias edit="code ~/.zshrc"
alias myip="curl http://ipecho.net/plain; echo"

# ssh aliases
alias gwen="ssh josh@192.168.1.6"
alias gwenmnt="sshfs josh@192.168.1.6:/ ./mnt/gwen"
# locations
alias proj="cd '$HOME/Resilio Sync/Getting Things Done/01 - Projects'"
# jekyll
alias jks="bundle exec jekyll serve --livereload"

# SFDX
sfopen () { sfdx force:org:open -u $1; exit; }


# functions
mcd () {
    mkdir -p $1
    cd $1
}


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

# theme - see https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
plugins=(
  git
  npm
  pyenv
  sdk
  sfdx
  zsh-autosuggestions
  z
  zsh-syntax-highlighting
  )
source $ZSH/oh-my-zsh.sh
source ~/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme
setopt HIST_IGNORE_SPACE

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"