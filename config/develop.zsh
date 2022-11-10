ZSH_THEME="gruvbox"
SOLARIZED_THEME="dark"

plugins=(git zsh-completions zsh-autosuggestions zsh-syntax-highlighting)

#autoload -U compinit && compinit


export HOMEBREW_NO_ANALYTICS=1

alias b="sh $HOME/mampro/scripts/brew-stuff.sh update"
alias bc="sh $HOME/mampro/scripts/brew-stuff.sh cleanup"
alias bs="brew search "
alias bi="brew install "
alias bri="brew reinstall "
alias br="brew remove "
alias bd="brew doctor"
alias bfo="brew info "
alias bss="brew services start "
alias bsr="brew services restart "
alias bso="brew services stop "
alias bsl="brew services list"

alias a.s="sh $HOME/mampro/scripts/apache.sh start"
alias a.o="sh $HOME/mampro/scripts/apache.sh stop"
alias a.r="sh $HOME/mampro/scripts/apache.sh restart"

alias m.s="brew services start mariadb"
alias m.o="brew services stop mariadb"
alias m.r="brew services restart mariadb"

alias a.conf="sh $HOME/mampro/scripts/open-config.sh httpd"
alias v.conf="sh $HOME/mampro/scripts/open-config.sh vhosts"

alias x="sh $HOME/mampro/scripts/php-xdebug.sh"
alias x.d="sh $HOME/mampro/scripts/php-xdebug.sh d"
alias x.e="sh $HOME/mampro/scripts/php-xdebug.sh e"

alias o="sh $HOME/mampro/scripts/php-opcache.sh"
alias o.d="sh $HOME/mampro/scripts/php-opcache.sh d"
alias o.e="sh $HOME/mampro/scripts/php-opcache.sh e"

alias dump="sh $HOME/mampro/scripts/mariadb-export.sh"
alias dbexport="sh $HOME/mampro/scripts/mariadb-export.sh"
alias dbimport="sh $HOME/mampro/scripts/mariadb-import.sh"
