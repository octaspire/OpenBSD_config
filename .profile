PATH=$HOME/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:/usr/local/bin:/usr/local/sbin:/usr/games
export PATH HOME TERM
export VISUAL=mg
export LC_CTYPE=C.UTF-8

export PS1="\A|\u|\W$ "

alias ls='colorls -G'
alias la='ls -lath'
alias wip='git commit -am WIP'

export PKG_PATH="https://ftp.eu.openbsd.org/pub/OpenBSD/$(uname -r)/packages/$(arch -s)/"
export GPG_TTY=$(tty)
