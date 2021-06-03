
function add_inotify_max() {
  echo /etc/sysctl.conf append line
  echo "fs.inotify.max_user_watches=1048576"

  echo "fs.inotify.max_user_watches=1048576" | sudo tee -a /etc/sysctl.conf
  sudo sysctl -p
}


function change-gnome-shell-theme-config-css() {
  sudo update-alternatives --config gdm3.css
}


function dconf-config-load-export() {
  # export all config
  dconf dump / > root.dconf
  # import all config
  dconf load / < root.dconf

  # demo
  # dconf dump /org/gnome/settings-daemon/plugins/media-keys/ > custom-keybindings.dconf
  # dconf load /org/gnome/settings-daemon/plugins/media-keys/ < custom-keybindings
}




function xcursor-format() {
  local d='.'
  if [ ! -z "$*" ]; then
    d=`dirname "$1"`
  fi

  pushd $d

  cp row-resize  row-bak
  cp col-resize  col-bak
  cp nesw-resize  nesw-bak
  cp nwse-resize  nwse-bak

  rm -rf *resize

  cp row-bak   row-resize
  cp col-bak   col-resize
  cp nesw-bak   nesw-resize
  cp nwse-bak   nwse-resize

  ln -s row-resize  ns-resize
  ln -s col-resize  ew-resize

  ln -s ns-resize  n-resize
  ln -s ns-resize  s-resize
  ln -s ew-resize  e-resize
  ln -s ew-resize  w-resize

  ln -s nesw-resize  ne-resize
  ln -s nesw-resize  sw-resize
  ln -s nwse-resize  nw-resize
  ln -s nwse-resize  se-resize

  popd

  echo "[OK] convert to windows cursor like "
}


# mkdir && touch
alias mkdir_by_path='touch_path';

function touch_path() {
  local dir=`dirname "$1"`
  local fname=`basename "$1"`

  mkdir -p "$dir"
  touch "$1"
  ls "$1"
}

function count_disk_usage() {
  find -mtime -10 -type f -exec du '{}' \; | awk '{s+=$1} END {print s}'
}

function dsize() {
  du -h
}


function mame_test() {
  for rom in $(ls *.zip); do
    echo $rom - "${rom%%.*}"
    mame -verifyroms "${rom%%.*}"
  done
}

alias lnode='ls --inode'
