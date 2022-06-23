# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/fonsecajavier/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  bundler
)

source $ZSH/oh-my-zsh.sh

# Python 2 was deprecated from macOS 12.3 (Monterey), but some scripts and commands
# will still require the `python` (Python 2) command to exist, for example:
# zsh-git-prompt - git_super_status
#
# If you want Python 2 installed again for maximum compatibility, you can do so via
# `pyenv` and symlinks. Please follow the instructions from:
# https://www.alfredapp.com/help/kb/python-2-monterey/
#
# In the other side, if you don't want to install that old version of Python, you could
# could try to alias the `python` command with the `python3` binary from Homebrew:
# alias python=/usr/local/bin/python3

source ~/.zsh/zsh-git-prompt/zshrc.sh
PROMPT='%B%m%~%b$(git_super_status) %# '
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin

export PATH=$PATH:/usr/local/bin/platform-tools # ADB

export ANDROID_HOME=/Users/fonsecajavier/Library/Android/sdk
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=/Users/fonsecajavier/Library/Python/3.7/bin:$PATH

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source $HOME/tokens.sh # This loads NPM_TOKEN, and other tokens as env vars via `export`

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

sudoSearchAndDestroy(){
  # kill processes on some tcp port:
  if [ -z "$1" ]; then
      echo "Usage: searchAndDestroy [numeric port identifier]" >&2
      return 1
  fi
  sudo lsof -i TCP:$1 | awk '/LISTEN/{print $2}' | xargs kill -9
}
alias rake='noglob rake' # prevents "zsh: no matches found: task[param]" not found error when passing parameters to ruby rake tasks

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES # fixes fork related problems with Puma and other web servers

export FZF_DEFAULT_COMMAND='rg --files' # allows FZF (fuzzy finder in VIM) to use RipGrep (rg) instead of regular find command

alias vim="nvim"
alias vi="nvim"
alias oldvim="vim"

export EDITOR="nvim"

# Some libraries/versions such as node-gpy require python 2 to be available
export npm_config_python=`which python`
