#!/usr/bin/env python

from random import randint

rand_color = hex(randint(0, int(0xFFFFFF)))[2:]

print('#{}'.format(rand_color))
