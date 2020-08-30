import subprocess

def find_corners(screen_name="VGA1"):
    """
    given the name of a screen (found with arandr or xrandr with no arguments),
    return the screen coordinates of each corner

    top left of xrandr's whole virtual screenspace is (0, 0)
    if VGA is touching its top left corner with the bottom right corner of your main display:

        0------+
        | main |
        |      |
        +------+-----+
               | VGA |
               |     |
               +-----+

    ...main display's top left coord will be (0, 0) (indicated with a 0)
    VGA (or whatever your second screen is named), its bottom right coordinate will be
         x: main's width + VGA's width
         y: main's height + VGA's height

    if the second screen's bottom left corner is aligned with main's top right, 

        0      +-----+
               | VGA |
               |     |
        +------+-----+
        | main |
        |      |
        +------+

    ... main's bottom right will be:
        x: main's width
        y: VGA's height + main's height

    """
    command = "xrandr"
    process = subprocess.Popen(
        command.split(),
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )
    stdout, stderr = process.communicate()
    #split stdout on newlines:
    lines = str(stdout).split('\\n')
    #find just the line with the resolution string:
    grepped = [line for line in lines if "VGA1" in line][0]
    #separate out just the resolution string:
    resolution_string = list(filter(lambda x: '+' in x, grepped.split()))
    #replace x and + characters with spaces:
    cleaned = resolution_string[0].replace('x', ' ').replace('+', ' ').split()
    #cast as ints and assign to readable names:
    width, height, x_offset, y_offset = [int(val) for val in cleaned]
    top_left = (x_offset, y_offset)
    top_right = (width + x_offset, y_offset)
    bottom_left = (x_offset, y_offset + height)
    bottom_right = (x_offset + width, y_offset + height)
    print("top_left:", top_left)
    print("top_right:", top_right)
    print("bottom_left:", bottom_left)
    print("bottom_right:", bottom_right)
    return (top_left, top_right, bottom_right, bottom_left)

def main():
    print("find_corners():")
    find_corners()

main()
