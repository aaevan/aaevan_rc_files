#epoch seconds then date (easier to sort)
path=~/notes/note_$(date '+%s_%m-%d-%y_%H-%M-%S').txt
#simple date
#path=~/notes/note_$(date '+%m-%d-%y_%H-%M-%S').txt
cp ~/todo_template.txt $path
#date prefaced by seconds since 1970
echo "todos for `date '+%m-%d-%y (started at %H:%M:%S)'`:\n$(cat $path)" > $path
#just the date, harder to sort
#echo "todos for `date '+%m-%d-%y (started at %H:%M:%S)'`:\n$(cat $path)" > $path
gvim $path
