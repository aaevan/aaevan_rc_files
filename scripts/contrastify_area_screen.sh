#!/bin/bash

#take a screenshot:
import /home/aaron/ankify/screenshot$(date '+%m-%d-%y_%H-%M-%S').png

#take the last file in my screenshots directory and perform contrasting step:
python ~/scripts/pil_test.py ~/ankify/`ls -Art ~/ankify | tail -n 1` out
