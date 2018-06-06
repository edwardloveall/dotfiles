if [[ -e /usr/local/share/chruby ]]; then
  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh
fi

chruby ruby-2

# load our own completion functions
fpath=(~/.zsh/completion $fpath)

# Local and default paths
export PATH="$HOME/.bin:/usr/local/bin:/usr/local/sbin:$PATH"

# Postgres path
export PATH="/usr/local/bin/psql:$PATH"

# Rust bin path
export PATH="$HOME/.cargo/bin/:$PATH"

# completion
autoload -U compinit
compinit

# automatically enter directories without cd
setopt auto_cd

# case insensitive completion for cd etc *N*
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Autocomplete ignores
zstyle ':completion:*:*' ignored-patterns '*ORIG_HEAD'

# use textmate as an editor
export EDITOR="vim"

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

# awesome cd movements from zshkit
setopt AUTOCD
setopt AUTOPUSHD PUSHDMINUS PUSHDSILENT PUSHDTOHOME
setopt cdablevars

# Enable extended globbing
setopt EXTENDED_GLOB

# Tell the terminal about the working directory whenever it changes.
if [[ "$TERM_PROGRAM" == "Apple_Terminal" ]] && [[ -z "$INSIDE_EMACS" ]]; then

    update_terminal_cwd() {
        # Identify the directory using a "file:" scheme URL, including
        # the host name to disambiguate local vs. remote paths.

        # Percent-encode the pathname.
        local URL_PATH=''
        {
            # Use LANG=C to process text byte-by-byte.
            local i ch hexch LANG=C
            for ((i = 1; i <= ${#PWD}; ++i)); do
                ch="$PWD[i]"
                if [[ "$ch" =~ [/._~A-Za-z0-9-] ]]; then
                    URL_PATH+="$ch"
                else
                    hexch=$(printf "%02X" "'$ch")
                    URL_PATH+="%$hexch"
                fi
            done
        }

        local PWD_URL="file://$HOST$URL_PATH"
        #echo "$PWD_URL"        # testing
        printf '\e]7;%s\a' "$PWD_URL"
    }

    # Register the function so it is called whenever the working
    # directory changes.
    autoload add-zsh-hook
    add-zsh-hook chpwd update_terminal_cwd

    # Tell the terminal about the initial directory.
    update_terminal_cwd
fi

# Environment vars
if [[ -a ~/.env ]]; then
  source ~/.env
fi

# Set window title to current directory
precmd () {print -Pn "\e]2;%1d\a"}

# Highlighting
source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PKG_CONFIG_PATH="/opt/local/lib/pkgconfig:$PKG_CONFIG_PATH"

# require for crystal compiler. See https://github.com/crystal-lang/crystal/issues/4745
export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig:$PKG_CONFIG_PATH"
