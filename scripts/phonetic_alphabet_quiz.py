from random import choice
from string import ascii_lowercase
from time import sleep

def main():
    interval = float(input("seconds (as a float) between clues? "))
    alphabet = {
        'a': 'alpha',
        'b': 'bravo',
        'c': 'charlie',
        'd': 'delta',
        'e': 'echo',
        'f': 'foxtrot',
        'g': 'golf',
        'h': 'hotel',
        'i': 'india',
        'j': 'juliette',
        'k': 'kilo',
        'l': 'lima',
        'm': 'mike',
        'n': 'november',
        'o': 'oscar',
        'p': 'papa',
        'q': 'quebec',
        'r': 'romeo',
        's': 'sierra',
        't': 'tango',
        'u': 'uniform',
        'v': 'victor',
        'w': 'whiskey',
        'x': 'x-ray',
        'y': 'yankee',
        'z': 'zulu',
    }

    while True:
        key = choice(ascii_lowercase)
        value = alphabet[key]
        print("{}?\n".format(key))
        sleep(interval)
        print("{}!\n".format(value))

main()
