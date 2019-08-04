unsetopt global_rcs
eval "$(rbenv init -)"
eval "$(nodenv init -)"

# source ~/perl5/perlbrew/etc/bashrc
export GPG_TTY=$(tty)

export PATH="$HOME/.cargo/bin:$PATH"
