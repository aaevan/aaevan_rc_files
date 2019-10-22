import subprocess
from time import sleep
from random import randint, random
from rand_color import random_rgb

print_string = "_"*49
args = (print_string, 0, 0, random_rgb())
cmd = r'echo {} | osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --offset={} -i {} -d 1 --color="{}" &'

x_size, y_size = 1600, 900
x_offset, y_offset = -5, -41

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
