#!/bin/bash

#if (((($1 % 2)) == 1))
if (($((`date '+%j'` % 2)) == 1))
then
    chromium $1
else
    chromium $2
fi

# for a third cycling branch, use an if statement that refers to somethign equaling 1, 2 or 3.
