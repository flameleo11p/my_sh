
function lsproxy() {
  echo $http_proxy
  echo $HTTPS_PROXY
  echo $ftp_proxy
  echo $all_proxy
}

function setproxy() {
  local port="37629"
  export http_proxy=http://127.0.0.1:$port/
  export https_proxy=https://127.0.0.1:$port/
  export ftp_proxy=ftp://127.0.0.1:$port/
  export socks_proxy=https://127.0.0.1:$port/
  export all_proxy=$socks_proxy

  export HTTP_PROXY=$http_proxy
  export HTTPS_PROXY=$https_proxy
  export FTP_PROXY=$ftp_proxy
  export SOCKS_PROXY=$socks_proxy
  export ALL_PROXY=$all_proxy

  export no_proxy="localhost, 127.0.0.0/8, ::1, *.aliyun.com, *.bilibili.com, *.edu.cn"
  export NO_PROXY=$no_proxy

  echo $http_proxy
  echo $https_proxy
  echo $ftp_proxy
  echo $all_proxy

  # unset http_proxy
  # unset https_proxy
}


function print_date() {
  # put current date as yyyy-mm-dd in $date
  date=$(date '+%Y-%m-%d')

  # put current date as yyyy-mm-dd HH:MM:SS in $date
  date=$(date '+%Y-%m-%d %H:%M:%S')

  # print current date directly
  echo $(date '+%Y-%m-%d')
}



function glass() {
  local x="$2"
  if [ -z "$2" ]; then
    x="50"
  fi

  if [ -z "$1" ]; then
    wmctrl -l
  else
    local value=$( printf 0x%x $((0xffffffff * $x/100)) );
    xprop -id $1 -format _NET_WM_WINDOW_OPACITY 32c -set _NET_WM_WINDOW_OPACITY $value
    # not allow to change _NET_WM_WINDOW_OPACITY
    # xprop -id $1 -set _NET_WM_WINDOW_OPACITY $value
    echo $value $x
  fi
}



function bakcrash() {
  mkdir -p /var/crash/mylog
  pushd /var/crash
  ls
  sudo mv *.crash mylog
  sudo mv *.upload mylog
  sudo mv *.uploaded mylog
  ls
  popd
}

function lscrash() {
  pushd /var/crash
  ls
}
