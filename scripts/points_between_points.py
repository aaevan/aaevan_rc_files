from sys import argv
import numpy as np
from math import sqrt

x1, y1, x2, y2 = [int(val) for val in argv[1:5]]
debug = False

if debug:
    print(f'x1 is: {x1}, y1 is: {y1} x2 is: {x2}, y2 is: {y2}')

dist = sqrt((x2 - x1)**2 + (y2 - y1)**2)
spacing = 15 #pixels
num_points = abs(dist // spacing)

#print(f'dist is: {dist}, num_points is {num_points}')

points = [
    *zip(
        np.linspace(x1, y1, num=int(num_points)),
        np.linspace(x2, y2, num=int(num_points)),
    )
]

rounded_points = [(int(x), int(y)) for x, y in points]

if debug:
    print("rounded_points:")
    print(rounded_points)

for x, y in rounded_points:
    print(f'{x} {y}')
