#!/usr/bin/env python

from random import randint

def random_rgb():
    rand_color = hex(randint(0, int(0xFFFFFF)))[2:]
    return '#{}'.format(rand_color)

if __name__=="__main__":
    rand_color = random_rgb()
    print(rand_color)

