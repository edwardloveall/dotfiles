# Local and default paths
export PATH="$HOME/.bin:/usr/local/bin:/usr/local/sbin:$PATH"

# asdf
source ~/.asdf/asdf.sh

# load our own completion functions
fpath=(~/.zsh/completion $fpath)

# Postgres path
export PATH="$PATH:/usr/local/bin/psql"

# Rust bin path
export PATH="$PATH:$HOME/.cargo/bin/"

# yarn path
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# completion
autoload -U compinit
compinit

# case insensitive completion for cd etc *N*
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Autocomplete ignores
zstyle ':completion:*:*' ignored-patterns '*ORIG_HEAD'

# set editor
export EDITOR="nova"

# functions
if [ -e "$HOME/.functions" ]; then
  source "$HOME/.functions"
fi

# aliases
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# use incremental search
bindkey "^R" history-incremental-search-backward

# add some readline keys back
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

# handy keybindings
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"

# expand functions in the prompt
setopt prompt_subst

# history settings
setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory
HISTSIZE=4096
SAVEHIST=4096

# automatically pushd
setopt auto_pushd
export dirstacksize=5

# automatically enter directories without cd
setopt auto_cd
setopt cdablevars

# ability to `cd -` and `cd -2`, `cd -3`, etc
setopt AUTOPUSHD PUSHDMINUS PUSHDSILENT PUSHDTOHOME

# Enable extended globbing
setopt EXTENDED_GLOB

# Environment vars
if [[ -a ~/.env ]]; then
  source ~/.env
fi

# Set window title to current directory
precmd () {print -Pn "\e]2;%1d\a"}

export PKG_CONFIG_PATH="/opt/local/lib/pkgconfig:$PKG_CONFIG_PATH"

# require for crystal compiler. See https://github.com/crystal-lang/crystal/issues/4745
export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig:$PKG_CONFIG_PATH"

# fzf key bindings and fuzzy completion:
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ripgrep config location
export RIPGREP_CONFIG_PATH=~/.ripgreprc

# Load a .local file if it exists
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
