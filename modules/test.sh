
# todo
function var() {
  echo $$1
}

function test_port() {
  lsof -i:$*
}


# # todo $0 $-1
# function backwardshell() {
#   ls | grep -Z "$*" | xargs sudo rm

#   ls /home/me/.pam_environment | xargs subl
# }



# test:
# ii libgnutls30
# d:amd64 r:amd64 i:amd64

# ii libgnutls30:i386
# ii libgnutls30:amd64

# ii libgnutls30=3.5.18-1ubuntu1.3
# ii libgnutls30:i386=3.5.18-1ubuntu1.3
# ii libgnutls30:amd64=3.5.18-1ubuntu1.3


function ddd111() {
  for deb in $(ls *.deb); do
    echo $deb
  done
}


function apt_update_single() {
  # for repo in "$@"; do
  #   echo $repo
  #   # sudo apt-get update -o Dir::Etc::sourcelist="sources.list.d/${repo}" \
  #   # -o Dir::Etc::sourceparts="-" -o APT::Get::List-Cleanup="0"
  # done
  echo 111
}

function emety_trash() {
  echo /home/me/.local/share/Trash/
}


function repeat(){
  for ((i=0;i<$1;i++)); do
    eval ${*:2}
  done
}

function start() {
  $* > $nul 2>&1 & disown
  # jobs
  # kill %1
  # kill %2

  # get last exit code
  # ret=$?
  # if [ $ret -eq 0 ]; then
}


# alias bg_='$* > /dev/null 2>&1 '
function bg_() {
  $* > $nul 2>&1
  # jobs
  # kill %1
  # kill %2
}


function cf() {
  echo $1
  # local ret=echo $1
  # if [[ $ret -ne 0 ]]; then
    local dir=`dirname "$1"`
    cd $dir
  # fi
}


function pushf() {
  echo $1
  # local ret=echo $1
  # if [[ $ret -ne 0 ]]; then
    local dir=`dirname "$1"`
    pushd $dir
  # fi
}


function compare_match_incase() {
  # dir=`dirname "$1"` 111
  # fname=`basename "$1"`

  echo $1, $2

  if echo $1 |grep -i ^$(echo $2)$; then
      echo it works
  fi

  [[ $1 =~ $2 ]] && echo "match" || echo "not"
  # echo `$*`    # as command
  # echo '$*'    # as no escape
  # echo "$*"    # as str  paser $var to ist content

}

function debugecho() {
  # to my custom app
  # "/home/me/app/bin/custom-app.sh"

  # "${@:2}"  seperate 2 "path"
  # "$args"  join to 1 "path"
  # $args   no "" maybe seperate by space to 4 path



  echo 1 $1
  echo 2 $2
  echo 3 $3
  echo 4 $4
  echo 5 $5
  echo 6 $6
  echo 7 $7

}


function debugmsg() {
  # to my custom app
  # "/home/me/app/bin/custom-app.sh"

  # "${@:2}"  seperate 2 "path"
  # "$args"  join to 1 "path"
  # $args   no "" maybe seperate by space to 4 path

  gxmessage "args:
  1 $1
  2 $2
  3 $3
  4 $4
  5 $5
  6 $6
  7 $7";

}

function logbash() {
  # echo logbash to ~/log/ (cache: ~/data)
  # mkdir ~/my-etc/data2/ && touch 111.txt
  # mkdir -p ~/my-etc/data4/ && pushd ~/my-etc/data4/ && touch 111.txt && popd

  # touch
  # exec ~/my-etc/data/bash_history.txt
  # lua filter get data to  ~/log/
  echo 111
}


# export MY_BASH_LOG_FILE="./logs/bash-usr_$EUID-$(date +"%Y_%m_%d").log"
function bash_script_log() {
  # local path="/home/me/Documents/bash-log/bash-usr_$EUID-$(date +"%Y_%m_%d").log"
  local path="$MY_BASH_LOG_FILE"
  local todo="$1"
  local status="off"


  # set $1 default
  if [ -z "$1" ]; then
    todo="on"
  fi

  if [ "$(ps -ocommand= -p $PPID | awk '{print $1}')" == 'script' ]; then
    status="on"
  fi

  # echo debug: $todo $status
  case $todo in
    on|start)
      test $status == "on" && echo bash log already turn on ||script -faq $path
      ;;

    c|status)
      echo status: $status
      ;;

    off|exit|quit|stop)
      test $status == "off" && echo bash log already stop || exit;
      ;;

    watch|show)
      test $status == "on" && echo please exit bash log first || tail -f $path;
      ;;

    *)
      echo bash_log not find $*
      ;;
  esac

}

function show_bash_input() {
  bash_script_log watch
}

function record_bash_input() {
  bash_script_log on
}
