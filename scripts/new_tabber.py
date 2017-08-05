#!/usr/bin/python2

import pyautogui
import time

print("Executing keystrokes!")


pyautogui.hotkey('ctrl', 'c')
time.sleep(.2)
pyautogui.hotkey('ctrl', 't')
time.sleep(.2)
pyautogui.hotkey('ctrl', 'v')
time.sleep(.1)
pyautogui.hotkey('enter')


