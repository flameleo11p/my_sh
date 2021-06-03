
# fast char option
alias g='grep -i $*'
alias gn='grep -iv $*'
alias gz='grep -iz $*'

alias rm='rm -i'
alias c='wc -l'

alias t='type'

# function
alias sudo='sudo '
alias p2do='sudo -u p2 -s '
alias xcopy='xargs cp -t $*'
# ls|g js|xcopy js

# alias ve='!$'
# alias va='${BASH_ALIASES[ve]}'
# alias vi='!$*'

alias p='ping $1 -c 5'

# short comamnd
alias getpass="openssl rand -base64 20"
alias ipe='curl ipinfo.io/ip'
alias ipi='ipconfig getifaddr en0'
alias sha='shasum -a 256 '
alias speed='speedtest-cli --server 2406 --simple'
alias untar='tar -zxvf '
alias wget='wget -c '
alias www='python -m SimpleHTTPServer 8000'
alias ping='ping -c 5'
alias pid='ps -aux |g $*'
# pgrep lutris
# pkill lutris

alias today='date +"%Y%m%d_%a"'
# %H: Display the hour.
# %M: Display the minute.
# %S: Display the seconds.
# date +"%Y%m%d%H%M%S"


# alias var='echo `$$1`'

alias pause='read -p "Press enter to continue"'


alias killbash='killall bash'
alias killterm='killall gnome-terminal-server'


# ls show all file
alias l1='ls -1'
alias la='ls -a'
alias ll='ls -halF'
alias lnode='ls --inode'



alias cnpm="npm --registry=https://registry.npm.taobao.org \
--cache=$HOME/.npm/.cache/cnpm \
--disturl=https://npm.taobao.org/dist \
--userconfig=$HOME/.cnpmrc"

