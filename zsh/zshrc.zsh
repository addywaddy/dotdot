# Setup automcompletion
fpath=(~/.zsh/completions $fpath)
autoload -U compinit
compinit
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

autoload -U zmv
alias mmv='noglob zmv -W'

# Vi key bindings
bindkey -e

# Includes
. ~/.zsh/functions.zsh
. ~/.zsh/completions.zsh
. ~/.zsh/colours.zsh
. ~/.zsh/aliases.zsh
. ~/.zsh/key_bindings.zsh
. ~/.zsh/prompt.zsh
. ~/.zsh/iterm.zsh
. ~/.zsh/ruby.zsh
. /usr/local/opt/asdf/libexec/asdf.sh

# Command history
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=100000
setopt autocd

# Directory history
DIRSTACKSIZE=10
setopt autopushd pushdminus pushdsilent pushdtohome

stty stop undef

setopt extended_glob

# If I am using vi keys, I want to know what mode I'm currently using.
# zle-keymap-select is executed every time KEYMAP changes.
# From http://zshwiki.org/home/examples/zlewidgets
function zle-keymap-select {
  VIMODE="${${KEYMAP/vicmd/ M:command}/(main|viins)/}"
  zle reset-prompt
}

zle -N zle-keymap-select
PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

ttyctl -f # The  -f  option  freezes the tty, enabling vim to receive <C-s> commands

function iterm2_print_user_vars() {
  iterm2_set_user_var kubecontext $(kubectl config current-context)
}

function iterm2_print_user_vars() {
  iterm2_set_user_var kubecontext $(kubectl config current-context)
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

GPG_TTY=$(tty)
export GPG_TTY

# See here for details:
# https://www.gnupg.org/documentation/manuals/gnupg/Invoking-GPG_002dAGENT.html#Invoking-GPG_002dAGENT

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/aws-okta aws-okta

# enable comments on the command line
setopt interactivecomments

autoload -Uz compinit && compinit

. /usr/local/opt/asdf/asdf.sh
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH=$PATH:$HOME/Scripts
export PATH=$PATH:$HOME/.cargo/bin
