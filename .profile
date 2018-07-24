PATH=$HOME/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:/usr/local/bin:/usr/local/sbin:/usr/games
export PATH HOME TERM
export VISUAL=mg
export LC_CTYPE="en_US.UTF-8"
export PS1="\A|\u|\W$ "
export PKG_PATH="https://ftp.eu.openbsd.org/pub/OpenBSD/$(uname -r)/packages/$(arch -s)/"
export GPG_TTY=$(tty)

alias ls='colorls -G'
alias la='ls -lath'
alias wip='git commit -am WIP'
alias e='emacsclient -t'
