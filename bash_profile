# Add Postgres 9.3 to the $PATH
export PATH=/usr/local/bin:/Applications/Postgres93.app/Contents/MacOS/bin:$PATH

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