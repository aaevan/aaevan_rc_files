import subprocess

def find_corners(screen_name="VGA1"):
    """
    doesn't work yet for primary display
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
