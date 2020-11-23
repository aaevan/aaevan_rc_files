path=~/notes/note_$(date '+%m-%d-%y_%H-%M-%S').txt
cp ~/todo_template.txt $path
echo -e "todos for `date`:\n$(cat $path)" > $path
gvim $path
