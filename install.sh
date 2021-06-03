
function main() {
  mkdir -p ./logs/bash_history/

  local entry="$(realpath ./index.sh)"
  local logfolder="$(realpath ./logs)"
  local root="$(realpath .)"


  echo create entry demo: .bash_aliases
  cp ./.bash_aliases.example ./.bash_aliases
  echo "export MY_SH_FOLDER=$root" >> ./.bash_aliases
  echo -en "if [ -f $entry ]; then\n  . $entry\nfi\n" >> ./.bash_aliases

  echo init log folder: $logfolder
  echo "export MY_BASH_LOG_FOLDER=$logfolder" > ./config.sh
  cat ./config.sh.example >> ./config.sh
  
}

main