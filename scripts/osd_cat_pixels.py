import subprocess
from time import sleep
from random import randint, random
from rand_color import random_rgb
from PIL import Image
from numpy import array

def rgb_to_hex(r, g, b):
    return '#{:02x}{:02x}{:02x}'.format(r, g, b)

def get_image_array(input_image):
    raw_image = Image.open(input_image)
    pixel_values = list(raw_image.getdata())
    print("raw_image.size:", raw_image.size)
    y_size, x_size = raw_image.size
    #pixel_values = array(pixel_values).reshape((*raw_image.size, 4))
    pixel_values = array(pixel_values).reshape((x_size, y_size, 4))
    return pixel_values

def print_image(input_image, duration=999, scaling=9, coords=(100, 100)):
    pixel_values = get_image_array(input_image)
    cmd = r'echo {} | osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --offset={} -i {} -d {} --color="{}" &'
    print(pixel_values.shape)
    for x_val, row in enumerate(pixel_values):
        for y_val, pixel in enumerate(row[::-1]): #row is reversed so image isn't mirrored
            r, g, b, a = pixel
            if a < 50:
                continue
            x_print, y_print = (x_val * scaling) + coords[0], (y_val * scaling) + coords[1]
            args = ('.', x_print, y_print, duration, rgb_to_hex(r, g, b))
            subprocess.call(cmd.format(*args), shell=True)


print_image('/home/aaron/key.png')
print_string = "_"*49
args = (print_string, 0, 0, random_rgb())
cmd = r'echo {} | osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --offset={} -i {} -d 1 --color="{}" &'

x_size, y_size = 1600, 900
x_offset, y_offset = -5, -41

"""
while True:
    sleep(1)
    for i in range(0, 1000, 4):
        #rand_x, rand_y = randint(0, x_size) - x_offset, randint(0, y_size) - y_offset
        #if random() < .99:
            #continue
        rand_x, rand_y = x_offset, i + y_offset
        args = (print_string, rand_y % 900 + y_offset, rand_x, random_rgb())
        returned_value = subprocess.call(cmd.format(*args), shell=True)
        sleep(.005)
"""
