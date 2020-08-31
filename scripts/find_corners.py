import subprocess
import time

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
    grepped = [line for line in lines if screen_name in line][0]
    #separate out just the resolution string:
    print("grepped:", grepped)
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

def get_timestamp():
    t = time.localtime()
    current_time = time.strftime("%H-%M-%S_%m-%d-%y")
    return current_time

def take_area_screenshot(
    top_left_coord, 
    bottom_right_coord, 
    out_dir_template="~/Pictures/area_gif_output/{}.png"
):
    x1, y1 = top_left_coord
    x2, y2 = bottom_right_coord
    screenshot_width, screenshot_height = x2 - x1, y2 - y1
    coord_string = "{},{},{},{}".format(x1, y1, screenshot_width, screenshot_height)
    out_dir = out_dir_template.format(get_timestamp())
    command = "shutter -s={} -e --output={}".format(coord_string, out_dir)
    process = subprocess.Popen(
        command.split(),
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )
    stdout, stderr = process.communicate()

def take_screenshot(
    out_dir_template="~/Pictures/{}.png"
):
    out_path = out_dir_template.format(get_timestamp())
    command = "import -window root {}".format(coord_string, out_path)
    process = subprocess.Popen(
        command.split(),
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )
    stdout, stderr = process.communicate()
    return out_path

def main():
    print("find_corners():")
    find_corners(screen_name="eDP1")
    take_area_screenshot((0, 0), (400, 400))

main()
