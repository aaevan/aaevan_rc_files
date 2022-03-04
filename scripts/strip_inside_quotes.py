import sys

debug = False

#joined_title = " ".join(sys.argv[3:])

if debug:
    print(f'sys.argv: {sys.argv}')

joined_title = " ".join(sys.argv)

if debug:
    print(f'joined_title: {joined_title}')
quote_index = joined_title.index('"')
second_quote_index = joined_title[quote_index + 1:].index('"')
if debug:
    print(f'quote index: {quote_index}')

stripped_title = joined_title[quote_index + 1:][:second_quote_index]

#strip inside quotes:
print(stripped_title)
