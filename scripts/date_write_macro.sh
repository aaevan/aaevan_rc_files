#from inside a vim document, type out a new file with the current timestamp

# pause here to debounce input so we don't fire off a litany of other commands 
# with mod4 and shift still held down (not doing this causes hilarious problems)
sleep 1

command_str=":w /home/aaron/notes/note_$(date '+%m-%d-%y_%H-%M-%S').txt"

xdotool type "$command_str"
