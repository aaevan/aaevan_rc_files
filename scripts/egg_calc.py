from math import sqrt
from time import sleep

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
    print(arr)
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
    print(f"input: coord_a:{coord_a}, coord_b:{coord_b}")
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

def bin_str_to_pretty_output(bin_str, line_length=6):
    output_list = []
    for index, char in enumerate(bin_str):
        if char == '1':
            output_list.append('●')
        else:
            output_list.append('○')
        if index == 5:
            output_list.append('  dist from center:    sum_dists:    permutation:   egg_coords:    \n')
    return ''.join(output_list)

def main():
    coord_dict = {
        0: (0,1), 1: (1,1), 2: (2,1), 3: (3,1), 4: (4,1), 5: (5,1),
        6: (0,0), 7: (1,0), 8: (2,0), 9: (3,0), 10: (4,0), 11: (5,0),
    }
    egg_permutations = get_egg_permutations(count = 3)
    center = (2.5, .5)
    print(egg_permutations)
    print(egg_permutations[0])
    min_dist = 999
    min_perm = None
    egg_dists = []
    for bin_str in egg_permutations:
        coord_list = bin_str_to_coords(bin_str=bin_str, coord_dict=coord_dict)
        #print(f"coord_list is: {coord_list}")
        avg_egg_coord = avg_xy(bin_str_to_coords(bin_str=bin_str, coord_dict=coord_dict))
        #print(f"avg_egg_coord is: {avg_egg_coord}")
        dist_from_center = point_to_point_dist(center, avg_egg_coord)
        sum_of_dists_from_center = sum_of_dists(arr=coord_list, center=center, )
        #print(f"sum_of_dists_from_center is: {sum_of_dists_from_center}")
        if dist_from_center <= min_dist:
            min_dist = dist_from_center
            min_perm = (coord_list, dist_from_center)
        #print(f"dist_from_center is: {dist_from_center}")
        print(bin_str_to_pretty_output(bin_str=bin_str))
        egg_dists.append(
            (
                round(dist_from_center, 16),
                round(sum_of_dists_from_center, 10), 
                bin_str, 
                coord_list
            )
        )
    print(min_dist, min_perm)
    #print(egg_dists)
    print(egg_dists[0])
    for row_num, row in enumerate(sorted(egg_dists, reverse=True)):
        print(len(egg_dists) - row_num, "-------------------------------------------------------------------")
        print(bin_str_to_pretty_output(row[2]), row)
    print("---------------------------------------------------------------------")



main()

