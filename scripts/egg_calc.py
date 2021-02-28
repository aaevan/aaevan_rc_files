from math import sqrt
from time import sleep
import sys

# Finds optimal arrangements of eggs in a 2x6 carton 
# such that the combined center of gravity will be as close
# as possible to the perceived center of gravity.

# turns out there's a lot of combinations that work equally fine:
# 3  eggs, 48 places tied for first
# 5  eggs, 144 places tied for first
# 7  eggs, 144 places tied for first
# 9  eggs, 48 places tied for first
# 11 eggs, 4 places tied for first

# more average mass of egg closer to the center point
# means less of a surprise when picking up the carton.

# configurations are given as a list of coordinates:
# [(0, 1), (1, 1), (2, 1)]3
# the success of a configuration is given by the distance 
# of its average coordinate from (2.5, .5)

# permutations of egg arrangements are converted from a 
# binary string ('111000000000') to an array of coords. 
# as if we were reading positions left to right, top to bottom,
# position 0 of the string is position (0, 1), position 11 is 
# position (5, 0)

def avg_xy(arr):
    x_sum, y_sum = 0, 0
    for coord in arr:
        x_sum += coord[0]
        y_sum += coord[1]
    avg_x = x_sum / len(arr)
    avg_y = y_sum / len(arr)
    return (avg_x, avg_y)

def sum_of_dists(arr=[(0, 0)], center=(2.5, .5), ):
    dist_sum = 0
    for coord in arr:
        dist = point_to_point_dist(center, coord)
        dist_sum += point_to_point_dist(center, coord)
    return dist_sum

def point_to_point_dist(coord_a, coord_b):
    x_diff, y_diff = (
        coord_b[0] - coord_a[0],
        coord_b[1] - coord_a[1],
    )
    return sqrt(x_diff ** 2 + y_diff ** 2)

def get_egg_permutations(slots = 12, count = 3):
    n_eggs = []
    for i in range(0, 2 ** slots):
        bin_str = bin(i)[2:]
        if bin_str.count('1') == count:
            n_eggs.append(bin_str.zfill(12))
    return n_eggs

def bin_str_to_coords(bin_str, coord_dict):
    output_list = []
    for index, char in enumerate(bin_str):
        if char == '1':
            output_list.append(coord_dict[index])
    return output_list


def bin_str_to_pretty_output(bin_str='010101101010', row=(), line_length=6):
    center_dist, sum_dists, bin_perm, egg_coords = row
    output_list = []
    for index, char in enumerate(bin_str):
        if char == '1':
            output_list.append('●')
        else:
            output_list.append('○')
    str_output = ''.join(output_list)
    first_egg_row, second_egg_row = str_output[:6], str_output[6:]
    line_1 = f'{first_egg_row}  center_dist   sum_dists     bin_perm      egg_coords'
    formatted_row = "{0:<14}{1:<14}{2:<14}{3:<14}".format(
        round(center_dist, 8),
        round(sum_dists, 8), 
        bin_perm,
        str(egg_coords),
    )
    line_2 = f'{second_egg_row}  {formatted_row}'
    print(line_1)
    print(line_2)

def main():
    if len(sys.argv) > 1:
        count_calc = int(sys.argv[1])
    else:
        count_calc = 3
    coord_dict = {
        0: (0,1), 1: (1,1), 2: (2,1), 3: (3,1), 4: (4,1), 5: (5,1),
        6: (0,0), 7: (1,0), 8: (2,0), 9: (3,0), 10: (4,0), 11: (5,0),
    }
    egg_permutations = get_egg_permutations(count = count_calc)
    center = (2.5, .5)
    egg_dists = []
    for bin_str in egg_permutations:
        coord_list = bin_str_to_coords(bin_str=bin_str, coord_dict=coord_dict)
        avg_egg_coord = avg_xy(
            bin_str_to_coords(bin_str=bin_str, coord_dict=coord_dict)
        )
        dist_from_center = point_to_point_dist(center, avg_egg_coord)
        sum_of_dists_from_center = sum_of_dists(
            arr=coord_list, center=center, 
        )
        egg_dists.append(
            (
                round(dist_from_center, 16),
                round(sum_of_dists_from_center, 10), 
                bin_str, 
                coord_list
            )
        )
    for row_num, row in enumerate(sorted(egg_dists, reverse=True)):
        print( len(egg_dists) - row_num, '-' * 67,)
        bin_str_to_pretty_output(bin_str=row[2], row=row)
    print('-' * 69)

main()

