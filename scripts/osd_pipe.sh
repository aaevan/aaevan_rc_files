pipe_name=/tmp/osd_cat_pipe
mkfifo $pipe_name

/home/aaron/scripts/random_echo.sh > $pipe_name &

osd_cat --pos=middle --align=center --color=red --font=-*-helvetica-bold-r-*-*-100-*-*-*-*-*-*-* --outline=4 --offset=-100 -d 1 -l 1 $pipe_name &
echo DONE!
