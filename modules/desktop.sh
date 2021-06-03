
function cmd() {
  # alias cmd='gnome-terminal'

  if [ -z "$*" ]; then
    echo gnome-terminal .
    # killall gnome-terminal-server
    # killall bash
    # exec env GTK_THEME=Arc gnome-terminal .
    GTK_THEME=Arc gnome-terminal .

  else
    echo sudo gnome-terminal $*
    sudo GTK_THEME=Arc gnome-terminal $*
  fi
}

function fs() {
  # nautilus -q
  if [ -z "$*" ]; then
    echo nautilus .
    run fs_1 .;
  else
    echo nautilus $*
    run fs_1 $*;
  fi
}

function FS() {
  sudo nautilus -q
  if [ -z "$*" ]; then
    echo sudo nautilus .
    run fs_1_root .;
  else
    echo sudo nautilus $*
    run fs_1_root $*;
  fi
}

function st3() {
  if [ -z "$*" ]; then
    if [[ . -ef ~ ]]; then
      run subl;
    else
      run subl .;
    fi
  else
    echo subl $*
    run subl $*;
  fi
}

function ST3() {
  if [ -z "$*" ]; then
    echo subl .
    run subl_root .;
  else
    echo subl $*
    run subl_root $*;
  fi
}

function vscode() {
  if [ -z "$*" ]; then
    echo code .
     code .
  else
    echo code $*
     code $*
  fi
}


function change_xterm() {
  sudo update-alternatives --config x-terminal-emulator
}

function ver_term(){
  term=$(ps -p $(ps -p $$ -o ppid=) -o args=);
  found=0;
  case $term in
    *gnome-terminal*)
      found=1
      echo "gnome-terminal " $(dpkg -l gnome-terminal | awk '/^ii/{print $3}')
      ;;
    *lxterminal*)
      found=1
      echo "lxterminal " $(dpkg -l lxterminal | awk '/^ii/{print $3}')
      ;;
    rxvt*)
      found=1
      echo "rxvt " $(dpkg -l rxvt | awk '/^ii/{print $3}')
      ;;
    ## Try and guess for any others
    *)
      for v in '-version' '--version' '-V' '-v'
      do
          $term "$v" &>/dev/null && eval $term $v && found=1 && break
      done
      ;;
  esac
  ## If none of the version arguments worked, try and get the
  ## package version
  [ $found -eq 0 ] && echo "$term " $(dpkg -l $term | awk '/^ii/{print $3}')
}

# converts and saves youtube video to mp3
function youtube_mp3() {
  youtube-dl --extract-audio --audio-format mp3 $1
}

# To create a new desktop shortcut launcher on Ubuntu 18.04 execute the following linux command:
# sudo apt-get install --no-install-recommends gnome-panel
function gnome_lnk() {
  gnome-desktop-item-edit --create-new .
}

function gnome_ext_debug() {
  journalctl -f -o cat /usr/bin/gnome-shell
}

function fix-gnome-setting() {
  gsettings set org.gnome.ControlCenter last-panel ''
  gnome-control-center
}


function gnome_reset() {
  # gnome-shell --replace
  # echo -r, --replace  Replace the running window manager
  # echo -d, --display=DISPLAY     X Display to use

  killall -3 gnome-shell
  DISPLAY=:0 gnome-shell -r &
}

function countdown_ui(){
  kronometer
}
function stopwatch_ui(){
  kronometer
}



function sound() {
  # aplay /usr/share/sounds/alsa/Side_Right.wav
  # paplay /usr/share/sounds/freedesktop/stereo/complete.oga
  local dir="~/Music/effect/notifications"
  local wav="$1"

  # set $1 default
  if [ -z "$1" ]; then
    wav="Positive.ogg"
  fi

  # 'Soft delay.ogg'
  # Amsterdam.ogg
  # Blip.ogg
  # Mallet.ogg
  # Positive.ogg
  # Rhodes.ogg
  # Slick.ogg
  # Xylo.ogg

  echo paplay
  # paplay $dir/$wav
  paplay ~/Music/effect/notifications/Positive.ogg &

  # paplay /usr/share/sounds/alsa/Side_Right.wav
}

# app shortcut
alias openra='/drive_d/game/openRA/OpenRA-Red-Alert-x86_64.AppImage'
alias red98='/drive_d/game/openRA/OpenRA-Red-Alert-x86_64.AppImage'


function app() {
  # to my custom app
  # "/home/me/app/bin/custom-app.sh"
  run "$@"
}



# wine shortcut
function run() {
  local name=$(string_lower $1)
  local args="${@:2}"
  local path=""
  local proton="/drive_d/SteamLibrary/steamapps/common/Proton 4.11/proton"
  # STEAM_COMPAT_DATA_PATH  
  # 434650  失落城堡
  # 692850  血月大剑
  local proton_pfx="/drive_d/SteamLibrary/steamapps/compatdata/434650/"


  echo $name
  case $name in
    # wine
      # WINEPREFIX="/drive_d/wine/dx9/" \
      # WINEPREFIX=~/wine/win10/
    "win-taskmgr")
      wine taskmgr
      ;;
    "win-subl")
    #   STEAM_COMPAT_DATA_PATH="/drive_d/game/compatdata/proton/" \
    #   "/drive_d/SteamLibrary/steamapps/common/Proton 4.11/proton" \
    #    run "/drive_d/dev/SublimeText3207/subl.exe" -n
      LANG=zh_CN.UTF-8 \
      wine "/drive_d/dev/SublimeText3207/subl.exe" -n
      return
      ;;

    "win-everything")
      wine "/drive_d/app/Everything-x64/Everything.exe"
      ;;

    "potplayer")
      wine "/drive_d/app/PotPlayer/PotPlayerMini.exe"
      ;;



    "win-track_folder")
      wine "/drive_d/app/TrackFolderChanges/TrackFolderChanges.exe"
      ;;

    "win-bc"|"proton_bc")
      STEAM_COMPAT_DATA_PATH="/drive_d/game/compatdata/proton/" \
      "/drive_d/SteamLibrary/steamapps/common/Proton 4.11/proton" \
       run "/drive_d/dev/BCompare3/BComp.exe"
      ;;


    "win-bcomp-diff")
      # /usr/bin/meld
      # /home/me/app/bin/bcomp
      # sdiff
      # icdiff
      local f1=$(winepath -w "$2")
      local f2=$(winepath -w "$3")

      # debugmsg "$2" "$3"
      # msgbox "$f1" "$f2"
      STEAM_COMPAT_DATA_PATH="/drive_d/game/compatdata/proton/" \
      "/drive_d/SteamLibrary/steamapps/common/Proton 4.11/proton" \
       run "/drive_d/dev/BCompare3/BComp.exe" "$f1" "$f2"
      ;;

    "win-bcomp-merge")
      local f1=$(winepath -w "$2")
      local f2=$(winepath -w "$3")
      local f3=$(winepath -w "$4")
      local f4=$(winepath -w "$5")

      # debugmsg "$2" "$3"
      # debugmsg "$f1" "$f2" "$f3" "$f4"
      # msgbox "$*"

      # WINEPREFIX="/drive_d/wine/dx9/" \
      # wine "/drive_d/dev/BCompare3/BComp.exe" "$f1" "$f2" "$f3" "$f4"
      # ;;
      STEAM_COMPAT_DATA_PATH="/drive_d/game/compatdata/proton/" \
      "/drive_d/SteamLibrary/steamapps/common/Proton 4.11/proton" \
       run "/drive_d/dev/BCompare3/BComp.exe" "$f1" "$f2" "$f3" "$f4"
      ;;

    "win-install")
      # /usr/bin/meld
      # /usr/bin/gxmessage
      # local f1=$(winepath -w "$2")
      # local f2=$(winepath -w "$3")

      # # debugmsg "$2" "$3"
      # debugmsg "$f1" "$f2"
      WINEPREFIX="/drive_d/wine/dx9/" \
      wine uninstaller
      ;;

    # proton
    "proton")
      STEAM_COMPAT_DATA_PATH="$proton_pfx" \
      "$proton" \
      run "$args";
      # /home/me/.wine/dosdevices/d:/SteamLibrary/steamapps/compatdata/692850/pfx/dosdevices/c:/users/steamuser/Local Settings/Application Data/BloodstainedRotN/Saved/SaveGames/Story_Slot*.sav
      ;;
    "proton-ce")
      STEAM_COMPAT_DATA_PATH="$proton_pfx" \
      "$proton" \
       run "/drive_d/dev/Cheat Engine 6.7/Cheat Engine.exe"
       # run "C:\Program Files (x86)\Cheat Engine 6.7\Cheat Engine.exe"
      ;;
    "proton-ce65")
      STEAM_COMPAT_DATA_PATH="$proton_pfx" \
      "$proton" \
       run "/drive_d/dev/Cheat Engine 6.5/Cheat Engine.exe"
      ;;
    "proton-ce67")
      STEAM_COMPAT_DATA_PATH="$proton_pfx" \
      "$proton" \
       run "/drive_d/dev/Cheat Engine 6.7/Cheat Engine.exe"
      ;;   
    "proton-ce70")
      STEAM_COMPAT_DATA_PATH="$proton_pfx" \
      "$proton" \
       run "/drive_d/dev/Cheat Engine 7.0/Cheat Engine.exe"
      ;;   

    "proton-ce72")
      STEAM_COMPAT_DATA_PATH="$proton_pfx" \
      "$proton" \
       run "/drive_d/dev/Cheat Engine 7.2/Cheat Engine.exe"
      ;;

    "proton-taskmgr")
      STEAM_COMPAT_DATA_PATH="$proton_pfx" \
      "$proton" \
       run taskmgr
      ;;
    "proton-regedit")
      STEAM_COMPAT_DATA_PATH="$proton_pfx" \
      "$proton" \
       run regedit
      ;;
    "proton-ahk")
      STEAM_COMPAT_DATA_PATH="$proton_pfx" \
      "$proton" \
       run "/drive_d/app/AutoHotkey-v1/AutoHotkey.exe" "/home/me/work/AutoHotkey/repeat-key.ahk"
       # run "C:\Program Files (x86)\Cheat Engine 6.7\Cheat Engine.exe"
      ;;
    "proton-ahk2")
      STEAM_COMPAT_DATA_PATH="/drive_d/SteamLibrary/steamapps/compatdata/692850/" \
      "$proton" \
       run "/drive_d/app/AutoHotkey-v1/AutoHotkey.exe" "/home/me/work/AutoHotkey/repeat-key2.ahk"
       # run "C:\Program Files (x86)\Cheat Engine 6.7\Cheat Engine.exe"
      ;;
    "proton-ahk-demo")
      STEAM_COMPAT_DATA_PATH="/drive_d/SteamLibrary/steamapps/compatdata/692850/" \
      "/drive_d/SteamLibrary/steamapps/common/Proton 4.11/proton" \
       run "/drive_d/app/AutoHotkey-v1/AutoHotkey.exe" "/home/me/work/AutoHotkey/demo/test-joystick-demo.ahk"
       # run "C:\Program Files (x86)\Cheat Engine 6.7\Cheat Engine.exe"
      ;;

    "play")
      # playonlinux
      # STEAM_COMPAT_DATA_PATH="/drive_d/SteamLibrary/steamapps/compatdata/692850/" \
      # "/drive_d/SteamLibrary/steamapps/common/Proton 4.11/proton" \
      # run "/drive_d/app/AutoHotkey-v1/AutoHotkey.exe" "/home/me/work/AutoHotkey/demo/test-joystick-demo.ahk"

      GTK_THEME=Arc playonlinux "${@:2}"
      ;;

    "war3-us-taskmgr")
      local mywine="/home/me/.local/share/lutris/runners/wine/lutris-5.0-x86_64/bin/wine"
      WINEESYNC=1 \
      WINEPREFIX="/drive_d/LutrisGames/battle_net_war3_en" \
      $mywine taskmgr
      ;;

    "war3x-test")
      # todo debug graphics, too dark
      local map=$(winepath -w "$2")
      # "/drive_d/BattleNetLibrary/Link to Warcraft III/Maps/test/last_test.w3m"
      local mywine="/home/me/.local/share/lutris/runners/wine/lutris-5.0-x86_64/bin/wine"
      WINEESYNC=1 \
      WINEPREFIX="/drive_d/LutrisGames/war3x-cn" \
      $mywine "/drive_d/BattleNetLibrary/Warcraft III/x86_64/Warcraft III.exe" \
      -launch -loadfile "$map" \
      -windowmode windowed -mapdiff 1 -testmapprofile Red -fixedseed 1
      ;;

    "war3x-pm")
      local mywine="/home/me/.local/share/lutris/runners/wine/lutris-5.0-x86_64/bin/wine"
      WINEESYNC=1 \
      WINEPREFIX="/drive_d/LutrisGames/warcraft-iii-reforged" \
      $mywine "/drive_d/dev/ProcessMonitor/Procmon.exe"
      ;;

    "war3x-ce")
      local mywine="/home/me/.local/share/lutris/runners/wine/lutris-5.0-x86_64/bin/wine"
      WINEESYNC=1 \
      WINEPREFIX="/drive_d/LutrisGames/warcraft-iii-reforged" \
      $mywine "/drive_d/app/Cheat Engine 6.7/Cheat Engine.exe"

      # 先启动lutris
      # 然后 再启动这个ce 貌似加了 esync标记后 就可以启动了
      # 明天在调试 找内存
      ;;

    "wow-ce")
      local mywine="/home/me/.local/share/lutris/runners/wine/lutris-5.0-x86_64/bin/wine"
      WINEESYNC=1 \
      WINEPREFIX="/drive_d/LutrisGames/battle_net_war3_en" \
      $mywine "/drive_d/app/Cheat Engine 6.7/Cheat Engine.exe"

      ;;
    "war3x-run")
      local mywine="/home/me/.local/share/lutris/runners/wine/lutris-5.0-x86_64/bin/wine"
      WINEESYNC=1 \
      WINEPREFIX="/drive_d/LutrisGames/warcraft-iii-reforged" \
      $mywine "$2" "${@:3}"

      # 先启动lutris
      # 然后 再启动这个ce 貌似加了 esync标记后 就可以启动了
      # 明天在调试 找内存
      ;;
    "war3-ahk")
      # local mywine="/home/me/.local/share/lutris/runners/wine/lutris-5.0-x86_64/bin/wine"
      # WINEESYNC=1 \
      # WINEPREFIX="/drive_d/LutrisGames/warcraft-iii-reforged" \
      # $mywine
      wine "/drive_d/app/AutoHotkey-v1/AutoHotkey.exe" "/drive_d/wine/.wine/drive_c/apps/Warkeys/WarKeys.ahk"
      ;;
    "war3x-ahk")
      local mywine="/home/me/.local/share/lutris/runners/wine/lutris-5.0-x86_64/bin/wine"
      WINEESYNC=1 \
      WINEPREFIX="/drive_d/LutrisGames/warcraft-iii-reforged" \
      $mywine "/drive_d/app/AutoHotkey-v1/AutoHotkey.exe" "/drive_d/work/AutoHotkey/war3x_world_editor_get_all_terrain.ahk"

      # STEAM_COMPAT_DATA_PATH="/drive_d/game/compatdata/stellaris/" \
      # "/drive_d/SteamLibrary/steamapps/common/Proton 4.11/proton" \
      #  run "/drive_d/app/AutoHotkey-v1/AutoHotkey.exe" "/home/me/work/AutoHotkey/stellaris-proton.ahk"
      ;;
    "star2-ahk")
      local mywine="/home/me/.local/share/lutris/runners/wine/lutris-5.4-x86_64/bin/wine"
      WINEESYNC=1 \
      WINEPREFIX="/drive_d/LutrisGames/starcraft2-TT5" \
      $mywine "/drive_d/app/AutoHotkey-v1/AutoHotkey.exe" "/drive_d/work/AutoHotkey/star2_del_friends.ahk"

      ;;


    "war3"|"war3-win")
      STEAM_COMPAT_DATA_PATH="/drive_d/game/compatdata/war3/" \
      LANG="zh_CN.UTF-8" \
      "/drive_d/SteamLibrary/steamapps/common/Proton 4.11/proton" \
       run "/drive_d/game/war3-121/War3.exe" -windows -opengl "$args"
      ;;
    "war3-full")
      STEAM_COMPAT_DATA_PATH="/drive_d/game/compatdata/war3/" \
      LANG="zh_CN.UTF-8" \
      "/drive_d/SteamLibrary/steamapps/common/Proton 4.11/proton" \
       run "/drive_d/game/war3-121/War3.exe" -opengl "$args"
       # -windows
      ;;

    "war3-run")
      STEAM_COMPAT_DATA_PATH="/drive_d/game/compatdata/war3/" \
      LANG="zh_CN.UTF-8" \
      "/drive_d/SteamLibrary/steamapps/common/Proton 4.11/proton" \
       run "${@:2}"
      # msgbox "${@:2}"
      ;;
    "war3-we")
      STEAM_COMPAT_DATA_PATH="/drive_d/game/compatdata/war3/" \
      LANG="zh_CN.UTF-8" \
      "/drive_d/SteamLibrary/steamapps/common/Proton 4.11/proton" \
       run "/drive_d/game/war3-121/worldedit.exe" -opengl "$args"
      ;;
    "war3-cfg")
      STEAM_COMPAT_DATA_PATH="/drive_d/game/compatdata/war3/" \
      LANG="zh_CN.UTF-8" \
      "/drive_d/SteamLibrary/steamapps/common/Proton 4.11/proton" \
       run regedit
      ;;

    "proton-star")
      STEAM_COMPAT_DATA_PATH="/drive_d/game/compatdata/stellaris/" \
      "/drive_d/SteamLibrary/steamapps/common/Proton 4.11/proton" \
       run "/drive_d/game/Stellaris/stellaris-LAN.exe"
       # run "D:\game\Stellaris2\stellaris-LAN.exe"
       # save location
       # /media/me/GIT1/game/Stellaris/Paradox Interactive/Stellaris
      ;;
    "proton-star2")
      STEAM_COMPAT_DATA_PATH="/drive_d/game/compatdata/stellaris2/" \
      "/drive_d/SteamLibrary/steamapps/common/Proton 5.0/proton" \
       run "/drive_d/game/Stellaris2/stellaris-LAN.exe"
       # run "/drive_d/game/Stellaris1/stellaris-LAN.exe"
      ;;
    "proton-star-ahk")
      STEAM_COMPAT_DATA_PATH="/drive_d/game/compatdata/stellaris/" \
      "/drive_d/SteamLibrary/steamapps/common/Proton 4.11/proton" \
       run "/drive_d/app/AutoHotkey-v1/AutoHotkey.exe" "/home/me/work/AutoHotkey/stellaris-proton.ahk"
       # run "/drive_d/app/AutoHotkey-v1/AutoHotkey.exe" "/home/me/work/AutoHotkey/stellaris-LAN.ahk"
       # run "C:\Program Files (x86)\Cheat Engine 6.7\Cheat Engine.exe"
      ;;

    "hollow_knight")
      STEAM_COMPAT_DATA_PATH="/drive_d/SteamLibrary/steamapps/compatdata/367520" \
      "/drive_d/SteamLibrary/steamapps/common/Proton 4.11/proton" \
       run "/drive_d/SteamLibrary/steamapps/common/Hollow Knight/hollow_knight.exe"
      ;;
    "hk-ce")
      STEAM_COMPAT_DATA_PATH="/drive_d/SteamLibrary/steamapps/compatdata/367520" \
      "/drive_d/SteamLibrary/steamapps/common/Proton 4.11/proton" \
       run "/drive_d/app/Cheat Engine 6.7/Cheat Engine.exe"
       # run "C:\Program Files (x86)\Cheat Engine 6.7\Cheat Engine.exe"
      ;;

    # xcross wine to linux
    "open-win")
      local file=$(winepath -u "${*:2}")
      # msgbox  "$file"
      xdg-open "$file"
      ;;
    "fs-win")
      local file=$(winepath -u "${*:2}")
      # msgbox  "$file"
      GTK_THEME=Flat-Remix-GTK-Green nautilus "$file"
      ;;

    "winx-copy-path")
      local file=$(winepath -u "${*:2}")
      udg_file3=$(winepath -u "${*:2}")

      # echo "$udg_file3" | xsel -b
      # msgbox "$file";
      # clipit $file
      echo "$file" |xsel -i ;

      ;;

    # linux
    meld)
      if [ -z "$2" ]; then
        GTK_THEME=Arc meld "/home/me/1.txt" "/home/me/2.txt"
      else
        GTK_THEME=Arc meld "${@:2}"
      fi
      ;;

    "fs")
      GTK_THEME=Flat-Remix-GTK-Green thunar "$args"
      ;;
    "fs-root")
      sudo -S GTK_THEME=Flat-Remix-GTK-Yellow thunar "$args"
      ;;


    "fs_1")
      # nautilus -q
      start env GTK_THEME=Flat-Remix-GTK-Green-Dark nautilus "$args"
      ;;
    "fs_1_root")
      sudo nautilus -q
      # env GTK_THEME=Flat-Remix-GTK-Red
      start sudo nautilus "$args"
      ;;

    "apt-pm")
      sudo -S GTK_THEME=Flat-Remix-GTK-Red synaptic "$args"
      ;;

    "diskgen")
      # Alternatives to DiskGenius
      # GParted. Extremely powerful partition manager. ...
      # TestDisk. TestDisk is a powerful free data recovery software! ...
      # MiniTool Partition Wizard. ...
      # Macrium Reflect. ...
      # PhotoRec. ...
      # Eraser. ...
      # Know any more alternatives to DiskGenius? ...
      # gnome-disk-utility.
      # bash -c "env GTK_THEME=Arc gparted"
      sudo -S GTK_THEME=Arc gparted "$args"
      ;;




    "dconf")
      killall dconf-editor
      GTK_THEME=Arc dconf-editor ${@:2}
      wmctrl -a "dconf Editor"
      wmctrl -r :ACTIVE: -e 0,50,50,800,600
      ;;

    "taskmgr")
      sudo killall gnome-system-monitor
      sudo GTK_THEME=Flat-Remix-GTK-Yellow-Dark gnome-system-monitor -p ${@:2}
      sudo wmctrl -a "System Monitor"
      ;;
    "taskmgr2")
      killall gnome-system-monitor
      GTK_THEME=Flat-Remix-GTK-Green gnome-system-monitor -r ${@:2}
      wmctrl -a "System Monitor"
      ;;

    "gimp")
      GTK_THEME=Arc gimp ${@:2}
      ;;
    "xterm")
      GTK_THEME=Arc gnome-terminal ${@:2}
      ;;

    "subl")
      GTK_THEME=Arc subl -n ${@:2}
      ;;
    "subl_root")
      sudo GTK_THEME=Flat-Remix-GTK-Red subl -n ${@:2}
      ;;


    "tweaks"|"skin"|"theme")
      killall gnome-tweaks
      GTK_THEME=Arc gnome-tweaks ${@:2}
      wmctrl -a "GNOME Tweaks"
      wmctrl -r :ACTIVE: -e 0,50,50,800,600
      ;;
    "setting")
      killall gnome-control-center
      GTK_THEME=Flat-Remix-GTK-Green-Dark gnome-control-center network ${@:2}
      wmctrl -a "Settings"
      ;;
    "setting-key")
      killall gnome-control-center
      GTK_THEME=Flat-Remix-GTK-Green gnome-control-center keyboard ${@:2}
      wmctrl -a "Settings"
      ;;

    *)
      echo app func no case for $*
      ;;

  esac

}


# wine shortcut
function win() {
  local name=$(string_lower $1)
  local path=""
  case $name in
    "cmd")
      path="cmd"
      ;;
    "fs")
      path="explorer"
      ;;
    "mine")
      path="C:\windows\syswow64\winemine.exe"
      ;;
    "taskmgr")
      run "win-taskmgr" "${@:2}"
      ;;
    "subl")
      run "win-subl" "${@:2}"
      ;;
    "everything")
      run "win-everything" "${@:2}"
      ;;
    bc|bcomp|bcompare)
      run "win-bc" "${@:2}"
      ;;
    *)
      echo win func no case for $*
      ;;
  esac

}




function update_desktop_lnk() {
  echo /var/lib/snapd/desktop/applications
  echo /usr/share/ubuntu/applications
  echo /usr/share/applications
  echo /usr/local/share/applications
  echo \~/.local/share/applications

  sudo update-desktop-database
}

# choose app
alias calc='kcalc'
alias diff='icdiff'

alias taskmgr='gnome-system-monitor'
alias explorer='xdg-open'

alias app-store='gnome-software'
alias logout='gnome-session-quit'


alias startup='sudo gnome-session-properties'

alias regedit='run dconf $*'

alias rd='update_desktop_lnk'
