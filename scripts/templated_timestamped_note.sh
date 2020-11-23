path=~/notes/note_$(date '+%m-%d-%y_%H-%M-%S').txt
cp ~/todo_template.txt $path
echo "todos for `date '+%m-%d-%y (started at %H:%M:%S)'`:\n$(cat $path)" > $path
gvim $path
