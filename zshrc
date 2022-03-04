#
# .zshrc is sourced in interactive shells.
# It should contain commands to set up aliases,
# functions, options, key bindings, etc.
#

##################
# LOAD FUNCTIONS #
##################

## completions
autoload -U compinit
compinit

## colors
autoload -U colors
colors

## renaming
autoload zmv
alias mmv='noglob zmv -W'

###############
# SET OPTIONS #
###############

#allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD

## Correct my spelling
setopt CORRECT

## Don't ask me
setopt RMSTARSILENT

## Don't require 'cd'
setopt AUTOCD

## Automatically pushd - then I can go to an old dir with cd - <tab> (pick no.)
setopt AUTOPUSHD
export DIRSTACKSIZE=11 # stack size of eleven gives me a list with ten entries

setopt PROMPT_SUBST

setopt +o nomatch
# unsetopt nomatch

# display non-zero exit codes from CLI processes
# setopt printexitvalue

## Autocomplete hosts from .ssh/known_hosts
#local _myhosts
#_myhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} )
zstyle ':completion:*' hosts $_myhosts

HISTSIZE=3000
SAVEHIST=3000
HISTFILE=~/.zsh_history

#####################
# SHELL ENVIRONMENT #
#####################

## Ctrl-W stops at a directory
## see http://www.zsh.org/mla/users/1995/msg00088.html
WORDCHARS='*?_-.[]~\!#$%^(){}<>|`@#$%^*()+:?'

## set up my prompt

export EDITOR=vim
bindkey -v

export LC_ALL=en_GB.UTF-8
export LANG=en_GB.UTF-8

export DISPLAY=:0.0

#############
# FUNCTIONS #
#############

###########
# ALIASES #
###########

## history
alias h='history'

## shortcuts
alias x='exit'
alias l='ls -Glh'
alias ls='ls -F'
alias ll='ls -alGh'
alias la='ls -A'
alias lla="ls -Ahl"
alias l.='ls -d .[^.]*'
alias lsd='ls -ld *(-/DN)'
alias lg='ls -l | grep -i'
alias lr='ls -lrt'
alias cd..='cd ..';
alias ..='cd ..'
alias df='df -h'

source ~/.dotfiles/zsh-git-prompt/zshrc.sh
PROMPT='%{${fg[yellow]}%}[%n@%m] %{${fg[green]}%}%4~%{${fg[default]}%}$(git_super_status) %# '

autoload -U +X bashcompinit && bashcompinit
