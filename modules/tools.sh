
function ls_line_count() {
  ls $* | wc -l
}

function delete_all_link() {
  find . -type l |xargs rm -f
}

function find_by_type() {
  find . -type l
}

function watch_log_file() {
  tail -f $1;
}

function dir() {
  # local di="$1"
  # local fi=`basename "$1"`

  # bg_ pushd $*

  # no recursive
  # ls $PWD/$*
  # ls -xm | head -n 2
  find "$(realpath .)"
  # recursive
  # find_in $*
  # bg_ popd
}

function find_in() {
  if [ -z "$*" ]; then
     find . -type f
    echo find .
  else
     find $* -type f
    echo find $*
  fi
}

function rem() {
  if [ "$1" == "echo" ]; then
    echo $*
  fi
}

function countdown_internal(){
   date1=$((`date +%s` + $1)); 
   while [ "$date1" -ge `date +%s` ]; do 
     echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
     sleep 0.1
   done
}

function countdown(){
  local sec=$(("$*"))
  countdown_internal sec
}

function stopwatch(){
  date1=`date +%s`; 
   while true; do 
    echo -ne "$(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r"; 
    sleep 0.1
   done
}


function string_upper() {
  local x="$*"
  echo ${x^^}
}

function string_lower() {
  local x="$*"
  echo ${x,,}
}

function string_camel() {
  local x="$*"
  x=${x,,}
  echo ${x^}
}


function string_split() {
  export IFS=";"
  sentence="one;two;three"
  for word in $sentence; do
    echo "$word"
  done
}

function sep() {
  # str_split : /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin
  # echo ''
  local str="${*:2}"
  export IFS="$1"
  for word in $str; do
    echo "$word"
  done
}



# rm_ls *.json
function rm_ls() {
  local match="$*"
  # local force=""
  # if [ "$1" == "-f" ]; then
  #   force 
  # fi
  if [ -z "$*"]; then
    match="untitled.txt"
  fi
  # ls $*
  for path in $(ls $match); do
    echo $path
    rm $path -f
  done

  # todo
  # -d -f to confirm

  echo "remove done"

}


function random_int() {
  local x=$(shuf -i $1-$2 -n 1)
  echo $x  
}


# merge_text "*.md"
function merge_text() {
  local match="$*"
  local name=""
  # local force=""
  # if [ "$1" == "-f" ]; then
  #   force 
  # fi
  if [ -z "$*" ]; then
    match="untitled.txt"
  fi
  # ls $*
  for path in $(ls $match); do
    # echo 11 $path
    name=$(echo "$path" | cut -c1-8)
    
    if [ $path != $name.md ]; then
      echo merge $path '>>' $name.md
      cat $path >> $name.md
      rm $path -f
    fi
  done

  # todo
  # -d -f to confirm
}
