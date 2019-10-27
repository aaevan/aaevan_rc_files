import asyncio
import subprocess
from time import sleep
from random import randint, random, shuffle
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
    #pixel_values = array(pixel_values).reshape((*raw_image.size, 4)) #for different pixel ordering.
    pixel_values = array(pixel_values).reshape((x_size, y_size, 4))
    return pixel_values

def print_image(input_image, duration=999, scaling=9, coords=(100, 100), 
                shuffle_order=True):
    pixel_values = get_image_array(input_image)
    cmd = r'echo {} | osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --offset={} -i {} -d {} --color="{}" &'
    print(pixel_values.shape)
    calls = []
    for x_val, row in enumerate(pixel_values):
        for y_val, pixel in enumerate(row[::-1]): #row is reversed so image isn't mirrored
            r, g, b, a = pixel
            if a < 50:
                continue
            x_print, y_print = (x_val * scaling) + coords[0], (y_val * scaling) + coords[1]
            args = ('.', x_print, y_print, duration, rgb_to_hex(r, g, b))
            if shuffle_order:
                calls.append(cmd.format(*args))
            else:
                subprocess.call(cmd.format(*args), shell=True)
    if shuffle_order:
        shuffle(calls)
        for osd_call in calls:
            subprocess.call(osd_call, shell=True)

x_size, y_size = 1600, 900
x_offset, y_offset = -5, -41

kill_cmd = "killall osd_cat"
while True:
    sleep(1)
    subprocess.call(kill_cmd, shell=True)
    print_image('/home/aaron/key.png')


