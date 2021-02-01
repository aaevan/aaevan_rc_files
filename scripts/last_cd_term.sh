#opens a terminal at the last cd'd to location.

last_cd=`history | grep -wv "cd .." | grep -E "\bcd"|tail -n 1`
cd_array=($last_cd)
last_dir=${cd_array[2]}
echo "last_cd is" $last_cd
echo "last_dir is" $last_dir

xfce4-terminal --hide-menubar --default-working-directory=$last_dir --zoom=-1

