# Case sensitive completion
CASE_SENSITIVE="true"

# Disable omz auto-update
DISABLE_AUTO_UPDATE="true"

autoload -Uz compinit && compinit

# Init zgen
source $HOME/.zsh/zgen.zsh

# zgen plugins
if ! zgen saved; then
    zgen oh-my-zsh

    # zgen oh-my-zsh plugins/brew
    zgen oh-my-zsh plugins/bundler
    zgen oh-my-zsh plugins/docker
    zgen oh-my-zsh plugins/gitfast
    zgen oh-my-zsh plugins/tmux
    zgen oh-my-zsh plugins/cp
    zgen oh-my-zsh plugins/nmap
    # zgen oh-my-zsh plugins/ssh-agent
    # zgen oh-my-zsh plugins/pip
    # zgen oh-my-zsh plugins/rsync
    # zgen oh-my-zsh plugins/helm
    # zgen oh-my-zsh plugins/kubectl
    # zgen oh-my-zsh plugins/go
    # zgen oh-my-zsh plugins/npm
    # zgen oh-my-zsh plugins/virtualenv

    zgen load rupa/z
    zgen load zsh-users/zsh-completions src
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load zsh-users/zaw

    zgen load ragnar-johannsson/dotfiles zsh.symlink/themes/ragnarb.zsh-theme

    zgen save
fi

# History settings
setopt inc_append_history
setopt share_history
setopt hist_ignore_all_dups
setopt hist_save_no_dups
export HISTSIZE=20000

# Zaw ack + history search
bindkey '^R' zaw-history
bindkey -M filterselect '^R' down-line-or-history
bindkey -M filterselect '^S' up-line-or-history
bindkey -M filterselect '^E' accept-search
bindkey -M filterselect 'F' accept-search
zstyle ':filter-select:highlight' matched fg=yellow
zstyle ':filter-select' max-lines 5
zstyle ':filter-select' extended-search yes

# PATHs

# Npm
# export PATH=$PATH:/usr/local/share/npm/bin

# Go
# export GOPATH=$HOME/dev/go
# export PATH=$PATH:$GOPATH/bin

# Pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
PATH=$HOME/.pyenv/shims:$PATH

# Perl
export PERL_MB_OPT="--install_base \"$HOME/perl5\""
export PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
PATH=$PATH:$HOME/.rvm/bin

# Brew
#export PATH=/usr/local/bin:/usr/local/sbin:$PATH:$HOME/.bin


# Custom
export PATH=$PATH:/usr/local/bin:/usr/local/sbin:$HOME/bin

# Vim
export EDITOR="vim"
alias vi=vim