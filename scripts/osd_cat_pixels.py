import subprocess
from time import sleep
from random import randint
from rand_color import random_rgb

args = (0, 0, random_rgb())
cmd = r'echo "." | osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --offset={} -i {} -d 1 --color="{}" &'

x_size, y_size = 1600, 900

while True:
    sleep(.01)
    rand_x, rand_y = randint(0, x_size) - 100, randint(0, y_size) - 30
    args = (rand_x, rand_y, random_rgb())
    #args = (0, 0, "blue")
    #print(args)
    #print(cmd.format(*args))
    returned_value = subprocess.call(cmd.format(*args), shell=True)
