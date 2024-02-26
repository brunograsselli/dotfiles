source ~/.shell-secrets

export CLICOLOR="auto"
export GIT_EDITOR="vim"
export GOPATH="$HOME/go"
export GOPRIVATE="github.com/brunograsselli/*"
export GREP_COLOR="4;33"
export GREP_OPTIONS="--color=auto"
export LC_ALL=en_US.UTF-8
export PATH="$PATH:$(go env GOPATH)/bin"

alias ls="ls --color=auto"
alias tree="tree -C"
alias ll="ls -ls"
alias acknt='ack --ignore-file=match:/_test.go$/'

set -o vi

setopt prompt_subst

RESET_COLOR="%f%b"

function __git_branch() {
        ref=$(git symbolic-ref --short HEAD 2> /dev/null)
        if [ -z "$ref" ]; then
                ref=$(git reflog 2> /dev/null | grep checkout | head -n1 | awk '{print $NF}')
        fi
        if [ -z "$ref" ]; then
                echo " "
        else
                echo " %F{blue}git:(%F{red}$ref%F{blue}) "
        fi
}

PROMPT='%(?.%F{green}➜.%F{red}➜)% %f%b %F{cyan}%c$(__git_branch)%F{blue}> %f%b'

# auto-completion
zstyle ':completion:*:*:*:*:*' menu select
autoload -U compinit
compinit

# history configuration
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt inc_append_history
setopt share_history # share command history data

bindkey -v
bindkey '^R' history-incremental-search-backward

[[ $commands[kubectl] ]] && source <(kubectl completion zsh)
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
