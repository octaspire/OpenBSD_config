PATH=$HOME/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:/usr/local/bin:/usr/local/sbin:/usr/games
export PATH HOME TERM
export VISUAL=mg
export PS1="\A|\u|\W$ "
export PKG_PATH="https://ftp.eu.openbsd.org/pub/OpenBSD/$(uname -r)/packages/$(arch -s)/"
export GPG_TTY=$(tty)

alias ls='colorls -G'
alias la='ls -lath'
alias wip='git commit -am WIP'
alias e='emacsclient -t'
alias make='gmake'
alias sha1sum='gsha1sum'
alias sha256sum='gsha256sum'
alias sha512sum='gsha512sum'

# Add custom ksh completion for the password store (pass) command.
# It works like this:
# 1. Find recursively all '*.gpg' files from '~/.password-store'
#    excluding files from directory '.git'.
# 2. Then replace in all the paths the part up to the end of
#    '.pasword-store/' and also '.gpg' in the end with empty strings.
#    Please note that because '~' is used in the sed substitution
#    command as a separator, it cannot appear in the user name.
# 3. The resulting strings are then used to create a custom ksh
#    completion for command 'pass' for the second argument:
OCTASPIRE_PASSDIR=~/.password-store
OCTASPIRE_PASSPATHS=$(find $OCTASPIRE_PASSDIR -path ./.git -prune -o -name '*.gpg' -print | sed "s~${OCTASPIRE_PASSDIR}/~~g" | sed 's~.gpg$~~g')
set -A complete_pass_2 -- $OCTASPIRE_PASSPATHS
