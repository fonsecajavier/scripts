# http://superuser.com/questions/244964/mac-os-x-bashrc-not-working
# This enables .bashrc for both login and non-login shells
[ -r ~/.bashrc ] && source ~/.bashrc

# Load the default .profile
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile"

# Add Postgres.app and mysql bins to the $PATH.  Make sure to double check this path
# exists.  Otherwise use the official Postgres.app/MySQL documentation for CLI-tools
export PATH=/usr/local/opt/gnu-tar/libexec/gnubin:$PATH
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/9.3/bin
export PATH=$PATH:/usr/local/mysql/bin
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH # required for the ruby gem to work

# Add /usr/local/bin to the $PATH so that brew installed programs can
# be run from everywhere.  Make sure to put it at the bottom of all $PATH
# redefinition.  In this way we make sure it's put at the top of the list
export PATH=/usr/local/bin:$PATH

# My fancy prompt:
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\] \[\033[33;1m\]\w \[\033[4;31m\](\$(git branch 2>/dev/null | grep '^*' | colrm 1 2))\[\033[0m\] \$ "

# Typing 'be' is cooler than 'bundle exec'
alias be='bundle exec'

# searchAndDestroy <PORT>.  Kills a process that is on any given port.
# Useful for stuck ruby processes
searchAndDestroy(){
  # kill processes on some tcp port:
  if [ -z "$1" ]; then
      echo "Usage: searchAndDestroy [numeric port identifier]" >&2
      return 1
  fi
  lsof -i TCP:$1 | awk '/LISTEN/{print $2}' | xargs kill -9
}

# Download .git-completion.bash from https://github.com/git/git/blob/master/contrib/completion/git-completion.bash
if [ -f ~/.git-completion.bash  ]; then
  . ~/.git-completion.bash
fi
