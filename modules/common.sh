

# msgbox $*
function msgbox() {
  # bash -c notify-send ${*:2}
  # zenity --info --text="${*:1}" --width=1000 --height=400 &
  # /usr/bin/xmessage
  gxmessage "args:
  1 $1
  2 $2
  3 $3
  4 $4
  5 $5
  6 $6
  7 $7";
  # export PATH="$PATH:/opt/wine-staging/bin/"
}


function lscolor() {
  local option="$1"
  if [ -z "$1" ]; then
    option="off"
  fi

  case $option in
    off|"0")
      alias ls='ls --color=never'
      ;;
    on|"1")
      alias ls='ls --color=auto'
      ;;
    *)
      echo lscolor option not find $*
      ;;
  esac
}

function lsnet() {
  sudo nethogs
}

function dns() {
  nslookup google.com
  # dig flameleo.tech +nostats +nocomments +nocmd
}

function dns2() {
  dig "$*" +nostats +nocomments +nocmd
}

function port() {
  lsof -i:$*
}

function port_all() {
  sudo lsof -i -P -n
}

function clean() {
  sudo apt autoremove
}

function lns() {
  rem ln -s [target] [lnk]     // soft link for file or folder
  ln -s "$1" "$2"
}

alias rlns='lnk'
function lnk() {
  rem ll [lnk] -\> [target]     // reverse ln -s
  echo lnk $1 -\> $2
  echo ln -s "$2" "$1"
  ln -s "$2" "$1"
}

# function
function sss() {
  echo -- apt-cache search -------------------------------------
  sudo apt-cache search $*

  echo -- apt search -------------------------------------
  sudo apt search $*

  echo -- snap find -------------------------------------
  sudo snap find $*
}

function apt-list() {

  echo -- apt-mark showmanual-------------------------------------
  apt-mark showmanual

  echo -- aptitude search -------------------------------------
  aptitude search '~i!~M'

  echo -- apt list -------------------------------------
  sudo apt list --installed $*

  echo -- snap find -------------------------------------
  sudo snap list $*

  # apt-file list gnome-keyring

  # list install location
  # dpkg -L tomcat7
}



alias i='install'
function install() {
  sudo apt install $*
}

function debi() {
  # gdebi
  # /usr/bin/gdebi
  sudo dpkg -i $*
  sudo apt-get install -f
}

function reinstall() {
  sudo apt install --reinstall $*
  # sudo apt install gir1.2-gdkpixbuf-2.0=2.36.11-2
}


alias v='ver_x96'
function ver_x96() {
  # sudo dpkg --add-architecture i386
  apt-cache policy $1
  apt-cache policy $1:i386
  apt-cache policy $1:amd64
}

function ver() {
  apt-cache policy $1
}

# alias ffi='force-reinstall'

function force-reinstall() {
  local ret=1
  mkdir -p ./deb && mv *.deb deb

  echo deb download format: name[:arch][=version]
  # $1 libgnutls30:i386=3.5.18-1ubuntu1.3
  local fullname="$1"
  echo apt-get download "$fullname"
  apt-get download "$fullname"
  ret=$?

  pkgname=$(echo $fullname | awk -F ':|=' {'print $1'})
  pkgname_arch=$(echo $fullname | cut -d "=" -f 1)

  # if [[ $fullname =~ ":i386" ]]; then
  #    pkgarch=":i386"
  # fi

  # 缺省时有bug
  # pkgarch=$(echo $fullname | awk -F ':|=' {'print $2'})
  # pkgver=$(echo $fullname  | awk -F ':|=' {'print $3'})
  # echo name[:arch][=version] $pkgname, $pkgver, $pkgarch
  echo $pkgname

  if [ $ret -eq 0 ]; then
    echo sudo dpkg -r --force-depends "$pkgname_arch"
    sudo dpkg -r --force-depends $pkgname_arch
  else
    echo '[abort] fail: apt-get download' "$fullname"
    return $ret
  fi

  echo ls $pkgname*.deb
  for deb in $(ls $pkgname*.deb); do
    echo '[install]: '$deb
    echo       sudo dpkg -i --force-all $deb
    sudo dpkg -i --force-all $deb
  done

  # v $pkgname
  return 0
}


function rdep() {
  apt-cache rdepends $*
}

function why() {
  aptitude why $*
}

function apt-why() {
  ver $*
  apt-cache depends $*
  apt-cache rdepends $*
  aptitude why $*
}

alias apt-dep='apt-why'


function apt-gui() {
  aptitude
}

function apt-src() {
  apt source $*
}

function remove() {
  sudo apt-get remove $*
}

function remove_all() {
  sudo apt-get remove $*
  sudo apt-get remove --auto-remove $*
  sudo apt-get purge $*
  sudo apt-get purge --auto-remove $*

  # apt-get autoremove
  # aptitude remove packagename
}

function uninstall() {
  sudo apt-get remove $*
  sudo apt-get remove --auto-remove $*
}

function apt-fix-broken() {
  # sudo apt-get clean && sudo apt-get update
  # sudo apt-get upgrade
  # sudo apt update
  # apt list --upgradable
  apt list --upgradable
  sudo apt autoremove
  sudo dpkg --configure -a
  sudo apt-get -f install
  # sudo dpkg --add-architecture i386
  # sudo aptitude install wine-staging
    # sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main'
  # sudo apt-get install --install-recommends winehq-staging
  # sudo mv /var/lib/dpkg/info/polar-bookshelf.* /tmp
}


alias clipit='copyit'
function copyit() {
  if [ -z "$*" ]; then
    echo [clipboard] copy: $PWD
    echo -n "$PWD" | xsel -bi
  else
    echo [clipboard] copy: $*
    echo -n "$*" | xsel -bi
  fi
}

function apt-levelup() {
  # alias SAUU='sudo apt update; sudo apt -y upgrade'

  sudo apt upgrade
}


function apt-repo() {
  # add-apt-repository -y $1
  echo add-apt-repository $1
  echo apt-get update
  echo apt-get install -y $2 $3 $4 $5 $6 $7 $8 $9

# apt-repo ppa:paulo-miguel-dias/pkppa mesa-utils mesa-vulkan-drivers

  sudo add-apt-repository $1 && \
  apt-update-install ${@:2}

  ver $2 $3 $4 $5 $6 $7 $8 $9
}

function apt-from() {
  # add-apt-repository -y $1
  echo add-apt-repository $1
  echo apt-get update
  echo apt-get $2 -y $3 $4 $5 $6 $7 $8 $9

  sudo add-apt-repository $1 && \
  apt-update-install ${@:3}
}

function apt-update-install() {
  sudo apt-get update
  sudo apt-get install -y $*
  ver $*
}

function giveme() {
  rem get current folder and all files permission
  local name=$(whoami)
  local dest=''
  if [ -z "$*" ]; then
    dest='.'
  else
    dest="$1"
  fi
  # chmod ug+rwx -R $*
  echo sudo chown -hR $name:$name $dest
  sudo chown -hR $name:$name $dest
}

function getchmod() {
  # stat -c '%a' [file]
  # stat -f "%OLp" [file]
  # stat --format '%a' [file]
  stat --format '%a' $*
}

function x() {
  # sudo chmod ug+rwx -R $*
  sudo chmod ugo+rx -R $*
}


function lastreboot() {
  # save reboot info /var/log/wtmp.1 
  # rollback 1200 month - 100 years
  last reboot $*
  last reboot $* -f /var/log/wtmp.1 
}

function locate_with_update() {
  # msgbox "$*"
  sudo updatedb && locate -i -e "$*"
}

function update_apt_repo() {
  sudo apt-get clean
   # && sudo apt-get update
  sudo apt update
  echo [upgradable]
  sudo apt list --upgradable
  echo sudo apt-get upgrade
}

# build
# source .bash_aliases
function updatesh() {
  local name=$(whoami)
  if ! [ "$HOME" -ef "/home/$name" ]; then
    cp /home/$name/.bash_aliases ~
  fi
  sudo cp /home/$name/.bash_aliases /root

  sudo ls ~/.bash_aliases
  sudo ls /root/.bash_aliases
  source ~/.bash_aliases

  # start paplay /usr/share/sounds/ubuntu/notifications/Positive.ogg
}

function sysinfo() {
  lsb_release -a
  uname -a
  # lsb_release -c
  # uname -r
}

function free_mem() {
  sudo sysctl -w vm.drop_caches=3
}

function bash_history_log() {
  # Eternal bash history.
  # export HISTFILE="./logs/bash_history/user_$EUID-$(date +"%Y_%m").log"
  export HISTFILESIZE=
  export HISTSIZE=
  export HISTTIMEFORMAT=" [%F %T]  # "
  export HISTIGNORE="r:ra:fs:hist:top:cmd:ps:history"
  PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
}


alias r='updatesh'
alias ra='update_apt_repo'
alias dbl='locate_with_update'
