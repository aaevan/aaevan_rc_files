#!/bin/bash

import -monochrome /home/aaron/ankify/screenshot$(date '+%m-%d-%y_%H-%M-%S').png

tesseract ~/ankify/`ls -Art ~/ankify | tail -n 1` out

gvim ~/out.txt
