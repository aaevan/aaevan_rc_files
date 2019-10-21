import subprocess
from time import sleep
from random import randint
from rand_color import random_rgb

args = (0, 0, random_rgb())
cmd = r'echo "TEST" | osd_cat --pos=top --align=right --font=-*-helvetica-bold-r-*-*-60-*-*-*-*-*-*-* --offset={} -i {} -d 1 -colour="{}" &'

while True:
    sleep(1)
    #args = (0, 0, random_rgb())
    args = (0, 0, "blue")
    print(args)
    print(cmd.format(*args))
    returned_value = subprocess.call(cmd.format(*args), shell=True)
