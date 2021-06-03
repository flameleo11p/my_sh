
function main() {
  mkdir -p ./logs/bash_history/
  mkdir -p ./dist/

  

  local entry="$(realpath ./index.sh)"
  local logfolder="$(realpath ./logs)"
  local root="$(realpath .)"


  echo dist entry demo: ./dist/.bash_aliases
  cp ./.bash_aliases.example ./dist/.bash_aliases
  echo "export MY_SH_FOLDER=$root" >> ./dist/.bash_aliases
  echo -en "if [ -f $entry ]; then\n  . $entry\nfi\n" >> ./dist/.bash_aliases

  echo init log folder: $logfolder
  echo "export MY_BASH_LOG_FOLDER=$logfolder" > ./config.sh
  cat ./config.sh.example >> ./config.sh
  
}

main