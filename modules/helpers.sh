

function my_bash_doc_help() {
  rem preserves the breaks between them \
  even if some of the arguments themselves contain spaces
  echo "${@:2}"
  rem as a single argument with spaces
  echo "${*:2}"
}

function port_help() {
  if [ -z "$1" ]; then
    return 
  else
    return
  fi

  i net-tools
  netstat -bano | more
  netstat -bano | grep LISTENING
  sudo nmap -sT -O localhost
  netstat -nat | grep LISTEN
  sudo lsof -i -P -n
  sudo ss -tulw
  sudo ss -tulwn

  netstat -tulpn
  sudo lsof -i -P -n
  sudo ss -tulwn
}


function location_auto_startup() {
  gnome-session-properties
  gnome-tweaks # startup
  cd /home/me/.config/autostart/
  # dbl autostart|g '.desktop$'
}

function nmcli_connect() {
  nmcli device status
  nmcli device connect enp7s0
  nmcli device disconnect enp7s0

  nmcli connection show --active
  nmcli connection down  ea7e43b6-b8a8-32b0-8087-a10d695f2f16
  nmcli connection up  ea7e43b6-b8a8-32b0-8087-a10d695f2f16
}

function ls_pip_demo() {
  ls | grep -i "$*"
  ls | grep -iZ "$*" | xargs sudo rm -r
}


function ubuntu-adduser-or-deluser_help() {
  sudo adduser p2
  # adduser: The user `p2' already exists.
  sudo deluser --remove-home p2
  # Looking for files to backup/remove ...
  # Removing files ...
  # Removing user `p2' ...
  # Warning: group `p2' has no more members.
}

function add_inotify_max() {
  echo /etc/sysctl.conf append line
  echo "fs.inotify.max_user_watches=1048576"

  echo "fs.inotify.max_user_watches=1048576" | sudo tee -a /etc/sysctl.conf
  sudo sysctl -p
}



function xsel_help() {
  # alias SAUU='sudo apt update; sudo apt -y upgrade'

  # input copy to clipboard
  # clipit xxx

  # copy
  # input to internal selection mem
  xsel -i < 1.txt
  echo xxx | xsel -i
  # apprend to ...
  echo xxx | xsel -a

  # output , paste
  xsel -o
  xsel
}






function systemd-analyze-helpers() {
# 使用system命令查看开机用时
  sudo systemd-analyze
  # 查看具体程序用时
  sudo systemd-analyze blame
  # 禁用一些服务如plymouth相关的两个。
  sudo systemctl mask plymouth-quit-wait.service
  # 恢复是把mask 改用unmask.
  # 这个服务是与开机动画相关的，占时间长。并且没用。不过去了以后总感到电脑好似死机了。
  # 禁用NetworkManager-wait-online.service这个服务网络服务并不会产生不良影响
  sudo systemctl disable NetworkManager-wait-online.service

}


function testsh() {
  echo "Fetching OpenAL-CS from GitHub."
  if command -v curl >/dev/null 2>&1; then
    echo 1
    # curl -s -L -O https://github.com/OpenRA/OpenAL-CS/releases/download/20190907/OpenAL-CS.dll
    # curl -s -L -O https://github.com/OpenRA/OpenAL-CS/releases/download/20190907/OpenAL-CS.dll.config
  else
    echo 2
    # wget -cq https://github.com/OpenRA/OpenAL-CS/releases/download/20190907/OpenAL-CS.dll
    # wget -cq https://github.com/OpenRA/OpenAL-CS/releases/download/20190907/OpenAL-CS.dll.config
  fi


  echo version: 112
}


function check_sys_log() {
  journalctl -af
}
