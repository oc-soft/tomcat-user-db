#! /usr/bin/bash

declare config_dir=config
declare tomcat_home=$TOMCAT_HOME
declare -a digest_opt=( -s 10 -i 5 )

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
-c [DIR]    specify configuration directory for users.csv. default config 
-t [DIR]    specify tomcat home directory. default TOMCAT_HOME environment
EOL
}


generate()
{
  local src=$1

  cat <$src | sed s/'${DB_NAME}'/$db_name/
}

main_proc()
{
  local src_path=$config_dir/users.csv.plain
  local dst_path=$config_dir/users.csv
  local digest
  local res=0
  if [ -n "$tomcat_home" ]; then
    digest=$tomcat_home/bin/digest.sh
  else
    digest=`which digest.sh`
  fi 
  test -x "$digest"
  res=$?
  
  if [ $res -eq 0 ] && [ -f $src_path ]; then
    : > $dst_path
    while read user pw; do
      local dgpw=`$digest ${digest_opt[*]} $pw | sed 's/.\+:\(.\+\)$/\1/'`
      echo -e "$user\t$dgpw" >>$dst_path 
    done <$src_path
  fi
  return $res
}


declare cmd=main_proc
while getopts hc:t: opt; do
  case $opt in #((((
    h)
      cmd=show_help
      ;;
    t)
      tomcat_home=$OPTARG
      ;;
    c)
      config_dir=$OPTARG 
      ;;
    :|?)
      cmd=show_help
      break
      ;;
  esac
done

$cmd

# vi: se ts=2 sw=2 et:
