#!/bin/bash
arecord -vv -fdat -d 10 test.wav
spek test.wav
