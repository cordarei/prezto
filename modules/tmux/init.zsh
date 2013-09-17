#
# Defines tmux aliases and provides for auto launching it at start-up.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Colin Hebert <hebert.colin@gmail.com>
#   Georges Discry <georges@discry.be>
#   Joseph Irwin <joseph.irwin.gt@gmail.com>
#

# Return if requirements are not found.
if (( ! $+commands[tmux] )); then
  return 1
fi

#
# Auto Start
#

if [[ -z "$TMUX" ]] && ( \
  ( [[ -n "$SSH_TTY" ]] && zstyle -t ':prezto:module:tmux:auto-start' remote ) ||
  ( [[ -z "$SSH_TTY" ]] && zstyle -t ':prezto:module:tmux:auto-start' local ) \
); then
  tmux_session='#Prezto'

  if ! tmux has-session -t "$tmux_session" 2> /dev/null; then
    # Ensure that tmux server is started.
    tmux start-server

    # Disable the destruction of unattached sessions globally.
    tmux set-option -g destroy-unattached off &> /dev/null

    # Create a new session.
    tmux new-session -d -s "$tmux_session"

    # Disable the destruction of the new, unattached session.
    tmux set-option -t "$tmux_session" destroy-unattached off &> /dev/null

    # Enable the destruction of unattached sessions globally to prevent
    # an abundance of open, detached sessions.
    tmux set-option -g destroy-unattached on &> /dev/null
  fi

  exec tmux new-session -t "$tmux_session"
fi

#
# Aliases
#

alias tmuxa='tmux attach-session'
alias tmuxl='tmux list-sessions'

#
# Functions
#

function fix-ssh {
  [[ -n "$SSH_AUTH_SOCK" ]] || return 1
  if [[ ! -S "$SSH_AUTH_SOCK" ]]; then
    local _sock="$(find-ssh-auth-sock)"
    if [[ -S "${_sock}" ]]; then
      ln -sf "${_sock}" "$SSH_AUTH_SOCK"
    fi
  fi
}

function t {
  if (( $# )); then
    return 1
  fi
  if [[ -z "$TMUX" ]]; then
    if [[ -S "$HOME/.ssh/auth-sock.$HOST" ]]; then
      SSH_AUTH_SOCK="$HOME/.ssh/auth-sock.$HOST" tmux-persistent-session
    else
      tmux-persistent-session
    fi
  else
    echo "Already inside a tmux session!" 1>&2
  fi
}
