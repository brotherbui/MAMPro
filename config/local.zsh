ZSH_THEME="gruvbox"
SOLARIZED_THEME="dark"

plugins=(git zsh-completions zsh-autosuggestions zsh-syntax-highlighting)

#autoload -U compinit && compinit


export HOMEBREW_NO_ANALYTICS=1


alias a.s='sh /Users/current_user/mampro/scripts/apache.sh start'
alias a.o='sh /Users/current_user/mampro/scripts/apache.sh stop'
alias a.r='sh /Users/current_user/mampro/scripts/apache.sh restart'

alias m.s='brew services start mariadb'
alias m.o='brew services stop mariadb'
alias m.r='brew services restart mariadb'

alias a.conf='sh /Users/current_user/mampro/scripts/open-config.sh httpd'
alias v.conf='sh /Users/current_user/mampro/scripts/open-config.sh vhosts'

alias x='sh /Users/current_user/mampro/scripts/php-xdebug.sh'
alias x.d='sh /Users/current_user/mampro/scripts/php-xdebug.sh d'
alias x.e='sh /Users/current_user/mampro/scripts/php-xdebug.sh e'

alias o='sh /Users/current_user/mampro/scripts/php-opcache.sh'
alias o.d='sh /Users/current_user/mampro/scripts/php-opcache.sh d'
alias o.e='sh /Users/current_user/mampro/scripts/php-opcache.sh e'

alias dump='sh /Users/current_user/mampro/scripts/mariadb-export.sh'
alias dbexport='sh /Users/current_user/mampro/scripts/mariadb-export.sh'
alias dbimport='sh /Users/current_user/mampro/scripts/mariadb-import.sh'
