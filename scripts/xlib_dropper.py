#!/usr/bin/env python

# Adapted from the xlib example from
# https://blog.wizardsoftheweb.pro/quickly-detect-cursor-position-and-color/#caveats

from __future__ import print_function

from os import getenv
from time import sleep

from Xlib.display import Display
from Xlib.X import ZPixmap

# Pull display from environment
DISPLAY_NUM = getenv('DISPLAY')
# Activate discovered display (or default)
DISPLAY = Display(DISPLAY_NUM)
# Specify the display's screen for convenience
SCREEN = DISPLAY.screen()
# Specify the base element
ROOT = SCREEN.root
# Store width and height
ROOT_GEOMETRY = ROOT.get_geometry()

# Ensure we can run this
EXTENSION_INFO = DISPLAY.query_extension('XInputExtension')

def get_mouse_location():
    return ROOT.query_pointer()

while True:
    COORDS = get_mouse_location()
    # Create an X dump at the coordinate we want
    DISPLAY_IMAGE = ROOT.get_image(
        x=COORDS.root_x,
        y=COORDS.root_y,
        width=1,
        height=1,
        format=ZPixmap,
        plane_mask=int("0xFFFFFF", 16)
    )
    # Strip its color info
    PIXEL = getattr(DISPLAY_IMAGE, 'data').hex()
    red = PIXEL[4:6] 
    green = PIXEL[2:4]
    blue = PIXEL[0:2]
    r, g, b = [int(val, 16) for val in (red, green, blue)]
    print()
    template = "x:{} y:{} pixel: {} r:{} g:{} b:{}, ({}, {}, {})"
    print(template.format(COORDS.root_x, COORDS.root_y, PIXEL, red, green, blue, r, g, b))
    sleep(.01)
