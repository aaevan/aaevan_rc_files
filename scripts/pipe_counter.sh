# usage: pipe_counter.sh <filename> <number of fields>

# sometimes the (LARGE) data files have too many or not enough pipe characters!
# this script will at least pick up on which lines (among -many-) are the culprits
# something else is needed to actually do the cleaning

# the first half is from this stackexchange post:
# https://unix.stackexchange.com/questions/18736/how-to-count-the-number-of-a-specific-character-in-each-line
# it counts how many instances of a pipe there are in each line of input.

# The second half (the grep) prepends a line number to an inverted search for lines that have
# the specified number of pipe characters in them
sed 's/[^|]//g' $1 | awk '{ print length }' | grep -n -v $2

