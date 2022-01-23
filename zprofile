# TODO for M1 macs
# eval "$(/opt/homebrew/bin/brew shellenv)"
case "$OSTYPE" in
  darwin*)
    # ...
  ;;
  linux*)
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
  ;;
  *)
    # ...
  ;;
esac