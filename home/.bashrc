#
# ~/.bashrc
#

[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

[[ -s "/home/samuel/.gvm/scripts/gvm" ]] && source "/home/samuel/.gvm/scripts/gvm"
. "$HOME/.cargo/env"
