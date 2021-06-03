
function main() {
  mkdir -p ./logs

  local entry="$(realpath ./index.sh)"
  local logfolder="$(realpath ./logs)"

  echo create entry demo: .bash_aliases
  cp ./.bash_aliases.example ./.bash_aliases
  echo -en "if [ -f $entry ]; then\n  . $entry\nfi\n" >> ./.bash_aliases


  echo init log folder: $logfolder
  cp ./modules/config.sh.example ./modules/config.sh
  echo "export MY_BASH_LOG_FOLDER=$logfolder" >> ./modules/config.sh
  
}

main