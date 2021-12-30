#strip_percentage.py

from sys import argv

joined_argv = ''.join(argv)

bracket_index = joined_argv.index('[')
percent_index = joined_argv.index('%')

print(joined_argv[bracket_index + 1:percent_index])

