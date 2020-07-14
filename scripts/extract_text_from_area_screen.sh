#!/bin/bash

#take a black and white area screenshot:
import -monochrome /home/aaron/ankify/screenshot$(date '+%m-%d-%y_%H-%M-%S').png

#take the last file in my screenshots directory and do OCR:
tesseract ~/ankify/`ls -Art ~/ankify | tail -n 1` out

#open the file in vim:
gvim ~/out.txt




