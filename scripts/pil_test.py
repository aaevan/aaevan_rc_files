from PIL import Image, ImageFilter
import sys
from math import sqrt


def point_to_point_distance(coord_a=(0, 0), coord_b=(10, 10)):
    x1, y1, x2, y2 = *coord_a, *coord_b
    return sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2)

def get_cells_in_circle(center=(0, 0), radius=10):
    """
    calculates points whose centers are less than or equal to the radius in
    distance from the center.

    takes only integer values of radius

    returns a 1d list of points
    """
    x_tuple = (center[0] - radius, center[0] + radius + 1)
    y_tuple = (center[1] - radius, center[1] + radius + 1)
    circle_coords = []
    for y in range(*y_tuple):
        for x in range(*x_tuple):
            if point_to_point_distance((x, y), center) <= radius:
                circle_coords.append((x, y))
    return circle_coords

def add_coords(coord_a=(2, 2), coord_b=(3, 3)):
    x1, y1, x2, y2 = *coord_a, *coord_b
    return (x1 + x2, y1 + y2)

def is_inside_bounds(
    check_coord=(50, 50), 
    top_left_coord=(0, 0), 
    bottom_right_coord=(100, 100),
):
    x1, y1, x2, y2 = *top_left_coord, *bottom_right_coord
    x_check, y_check = check_coord
    if x_check < x1 or x_check > x2:
        return False
    if y_check < y1 or y_check > y2:
        return False
    return True


def main(debug=False):
    input_file = sys.argv[1]
    im = Image.open(input_file).convert('RGB')
    pixels = im.load()
    im_copy = im.copy()
    pixels_copy = im_copy.load()
    # for each pixel in the image...
    circle_cell_offsets = get_cells_in_circle(radius=3, center=(0, 0))
    bottom_right_coord = (im.size[0] - 1, im.size[1] - 1)
    print("bottom right coord is:", bottom_right_coord)
    for i in range(im.size[0]):
        for j in range(im.size[1]):
            local_min_sum = 255 * 3
            local_max_sum = 0
            # for each pixel in a circle around the current pixel
            # find the local max_sum and min_sum
            for offset in circle_cell_offsets:
                offset_coord = add_coords((i, j), offset)
                if is_inside_bounds(
                    check_coord=offset_coord, 
                    top_left_coord=(0, 0), 
                    bottom_right_coord=bottom_right_coord,
                ):
                    inner_sum_attributes = sum(pixels[offset_coord])
                    if inner_sum_attributes < local_min_sum:
                        if debug:
                            print("updating local_min_sum from {} to {}, (min: {}, max: {})".format(
                                local_min_sum, 
                                inner_sum_attributes,
                                local_min_sum,
                                local_max_sum
                            ))
                        local_min_sum = inner_sum_attributes
                    if inner_sum_attributes > local_max_sum:
                        if debug:
                            print("updating local_max_sum from {} to {}, (min: {}, max: {})".format(
                                local_max_sum, 
                                inner_sum_attributes,
                                local_min_sum,
                                local_max_sum,
                            ))
                        local_max_sum = inner_sum_attributes
            # using local_min_sum and local_max_sum, find a grey value scaled
            # to that minimum and maximum:
            sum_attributes = sum(pixels[i, j])
            val_sum_range = local_max_sum - local_min_sum
            if val_sum_range == 0:
                pixels_copy[i, j] = (0, 255, 0)
                continue
            grey_value = 255 * ((sum_attributes - local_min_sum) / val_sum_range)
            whole_grey_value = round(grey_value)
            output_pixel = [whole_grey_value] * 3
            # get slightly more subtle greys by adding 1 to the r and b value if
            # the grey_value has a fractional value:
            if grey_value % 1 >= (1/3):
                output_pixel[0] += 1
            if grey_value % 1 >= (2/3):
                output_pixel[1] += 1
            pixels_copy[i, j] = tuple(output_pixel)
    im.show() #display original with system default
    im_copy.show() #display filtered with system default

if __name__ == "__main__":
    main()
