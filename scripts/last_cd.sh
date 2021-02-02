last_cd=`history | grep -wv "cd .." | grep -E "\bcd ~" | tail -n 1`
cd_array=($last_cd)
last_dir=${cd_array[2]}
after="${last_dir//\~/$HOME}"
echo $after




