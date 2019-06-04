#/usr/bin/env python3

import sys

if len(sys.argv) > 1:
    print('argv!')
    input_color = '0x' + sys.argv[1][1:].zfill(6)
else:
    print('stdin!')
    input_lines = [line for line in sys.stdin]
    print('input_lines:', input_lines)
    input_color = '0x' + input_lines[0][1:]
    print('input_color:', input_color)

inverse_int = int(0xffffff) - int(input_color, 16)
inverted_color = '#' + hex(inverse_int)[2:].zfill(6)

print(inverted_color)
