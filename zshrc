#
# .zshrc is sourced in interactive shells.
# It should contain commands to set up aliases,
# functions, options, key bindings, etc.
#

# need to load this first because hub is an alias to git
fpath=(~/.zsh $fpath)

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
export PS1="%{${fg[yellow]}%}[%n@%m] %{${fg[green]}%}%3~ %# %{${fg[default]}%}"
export RPS1="%{${fg[yellow]}%}%T%{${fg[default]}%}"

export EDITOR=vim
bindkey -v

export LC_ALL=en_GB.UTF-8
export LANG=en_GB.UTF-8

# export PATH=/usr/local/bin:$PATH:/usr/local/php5.2.3/bin
# export PATH=$HOME/bin:/usr/local/bin:/Developer/usr/bin:/usr/local/mysql/bin:/usr/local/apache2/bin:$PATH:$HOME/flex3sdk/bin:/usr/games
# export PATH=$HOME/bin:/usr/local/python/frameworks/Python.framework/Versions/2.6/bin:/usr/local/bin:/usr/local/mysql/bin:/usr/local/pgsql/bin:/usr/local/apache2/bin:/usr/local/php5/bin:/usr/local/macports/bin:/usr/local/freetds/bin:$PATH
# export PATH=$HOME/bin:/usr/local/python/frameworks/Python.framework/Versions/2.6/bin:/usr/local/bin:/usr/local/mysql/bin:/usr/local/apache2/bin:/usr/local/php5/bin:/usr/local/openssl/bin:/usr/local/macports/bin:/usr/local/freetds/bin:/Applications/Xcode.app/Contents/Developer/usr/bin:$PATH
# export PATH=$HOME/bin:$HOME/.rbenv/bin:/usr/local/bin:$PATH
# export CLASSPATH=$CLASSPATH:/usr/local/rhino/js.jar
export PATH=$HOME/bin:/usr/local/bin:$PATH

export DISPLAY=:0.0

# export RBENV_VERSION="1.9.3-p429"
# export RBENV_VERSION="2.0.0-p247"
# export RBENV_VERSION="2.1.1"

export PERKS_MYSQL_SOCKET_PATH=/tmp/mysql.sock

export SDK_API_MYSQL_PASSWORD=perx
export SDK_API_MYSQL_SOCKET_PATH=/tmp/mysql.sock
export SDK_API_APP_PATH=/Users/donal/dev/rails/sdk-api

export GUARD_IP_ADDRESS="10.0.1.4"

export PCA_MYSQL_SOCKET_PATH=/opt/boxen/data/mysql/socket
export PCA_APP_PATH=/Users/donal/dev/rails/pca_rails

export CANTOFLASH_MYSQL_SOCKET_PATH=/opt/boxen/data/mysql/socket
export CANTOFLASH_MYSQL_PASSWORD=cantoflash
export CANTOFLASH_APP_PATH=/Users/donal/dev/rails/cantoflash

export PERX_MYSQL_PASSWORD=perx
export PERX_MYSQL_SOCKET_PATH=/private/tmp/mysql.sock

# export PRIVATE_GEM_SERVER="http://gems:blu3dAwn@gems.getperx.com:8187"

export AWS_CONFIG_FILE=/Users/donal/.aws/config

# private vars
source /Users/donal/.private_vars

## color STDERR red
#exec 2>>(while read line; do
#  print '\e[91m'${(q)line}'\e[0m' > /dev/tty; done &)

#if [ "`uname`" = "Darwin" ]; then
#   compctl -f -x 'c[-1,-a][-1,-A] p[2]' -s "`/bin/ls -d1 /Applications/*/*.app /Applications/*.app | sed 's|^.*/\([^/]*\)\.app.*|\\1|;s/ /\\\\ /g'`"  -- open
#   alias run='open -a'
#fi

#############
# FUNCTIONS #
#############

pc() { awk "{print \$$1}" }
mdc() { mkdir -p "$1" && cd "$1" }
calc() { echo "$@" | bc -l -q -i }
dont() { echo "OK, I won't!" }
#'"

###########
# ALIASES #
###########

## history
alias h='history'

## shortcuts
alias x='exit'
alias j='jobs'
alias l='ls -Glh'
alias ls='ls -F'
#alias ll='ls -AhlG'
alias ll='ls -alGh'
alias la='ls -A'
alias lla="ls -Ahl"
alias l.='ls -d .[^.]*'
alias lsd='ls -ld *(-/DN)'
alias lg='ls -l | grep -i'
alias cd..='cd ..';
alias ..='cd ..'
alias df='df -h'
alias cdw='cd ~/Documents/writing'
alias cdr='cd ~/dev/rails'
alias cds='cd ~/src'
alias cdd='cd ~/dev'
alias cdg='cd ~/github'
alias cddg='cd ~/dev/github'
alias mystart='sudo /usr/local/mysql/bin/mysqld_safe &'
alias mystop='sudo /usr/local/mysql/bin/mysqladmin -u root -p shutdown'
alias vm='ssh root@192.168.97.128'
# alias vm='ssh root@192.168.97.129'
alias vmu='ssh root@192.168.97.130'
# alias cent='ssh root@10.0.1.23'
alias perx='ssh ubuntu@web1.getperx.com'
alias jive='ssh ubuntu@web1.jiveitup.com'
alias dev='ssh ubuntu@dev.getperx.com'
alias tdb='ssh ubuntu@ec2-54-251-10-56.ap-southeast-1.compute.amazonaws.com'
alias pca='ssh ubuntu@54.255.176.66'

alias my='/usr/local/mysql/bin/mysql -u root -p'

alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias touch='nocorrect touch'
alias ln='nocorrect ln'

alias igrep='grep -i'
alias rgrep='grep -R'
alias rigrep='grep -iR'

alias proxy='export http_proxy=http://192.168.1.102:3128;export HTTP_PROXY=$http_proxy;export FTP_PROXY=$http_proxy;export https_proxy=$http_proxy;export ftp_proxy=$http_proxy;'
alias noproxy="export http_proxy='';export HTTP_PROXY=$http_proxy;export FTP_PROXY=$http_proxy;export https_proxy=$http_proxy;export ftp_proxy=$http_proxy;"
alias updatedb='sudo /usr/libexec/locate.updatedb'
alias hosts='vim /etc/hosts'
alias flushdns='lookupd -flushcache'
alias bc='bc -l'
alias o.='open .'

## shortcuts to other machines
alias tgo='ssh e46762@goanna.cs.rmit.edu.au'
alias ty='ssh e46762@yallara.cs.rmit.edu.au'
alias tx='ssh -l xnwq -p 2222 xusu.net'
alias tkca='ssh -l krisnach -p 2222 www.krisnacheungarchitects.com.au'
alias tsh='ssh -p 10000 donal@67.23.12.30'
alias tifi='ssh -l donal 10.1.1.8'
alias tif='ssh -l donal 203.206.183.143'
# alias tnash='ssh -l root 113.20.3.83'
alias tnash='ssh -p 11000 -l donal nashape.com'
#alias fx='sftp -oPort=2864 xnwq@www.xusu.net'
alias fx='sftp xnwq@www.xusu.net'
alias fgo='sftp e46762@goanna.cs.rmit.edu.au'
alias fy='sftp e46762@yallara.cs.rmit.edu.au'

alias cdv='cd /Users/donal/dev/vagrants'
alias cdb='cd /opt/boxen'

# alias zf='/Users/donal/dev/zf/bin/zf.sh'
alias zf='/work/zf/current/bin/zf.sh'

alias rds='mysql -u perx -p -h production.ccfyzqu52kfe.ap-southeast-1.rds.amazonaws.com'

alias stageold='ssh ubuntu@175.41.146.69'
alias stage='ssh ubuntu@54.255.129.55'
alias beta='ssh ubuntu@54.179.130.211'

# if [ `ifconfig | grep 10.10.0.22 | wc -l` = 1 ]; then
#     proxy
# fi
#
[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh

# TODO
# source ~/.bin/tmuxinator.zsh

# TODO
# source /usr/local/bin/aws_zsh_completer.sh

source $HOME/src/zsh-git-prompt/zshrc.sh

PROMPT='%{${fg[yellow]}%}[%n@%m] %{${fg[green]}%}%4~%{${fg[default]}%}$(git_super_status) %# '

# TODO
# powerline-daemon -q
# source /Users/donal/dev/src/powerline/powerline/bindings/zsh/powerline.zsh

