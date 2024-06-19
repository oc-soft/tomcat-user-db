#! /usr/bin/bash

declare db_name=tmc
declare script_dir=scripts

show_help()
{
  local cmd_name=`basename $0`
  if [ -t 1 ]; then
    echo -e "\033[1m$cmd_name\033[0m [OPTIONS]"
  else
    echo "$cmd_name [OPTIONS]"
  fi
  cat <<EOL
-h          show this message 
-d [DB]     specify database name for tables. default tmc
EOL
}


generate()
{
  local src=$1

  cat <$src | sed s/'${DB_NAME}'/$db_name/
}

main_proc()
{
  for tmp in $script_dir/*tmpl; do
    local dest_name=`basename $tmp`
    dest_name=${dest_name%%.tmpl}
    local dest_path=`dirname $tmp`/$dest_name
    generate $tmp >$dest_path
  done
}


declare cmd=main_proc
while getopts hd:s: opt; do
  case $opt in #(((
    h)
      cmd=show_help
      ;;
    d)
      db_name=$OPTARG
      ;;
    s)
      script_dir=$OPTARG 
      ;;
    :|?)
      cmd=show_help
      break
      ;;
  esac
done

$cmd

# vi: se ts=2 sw=2 et:
