import sys

i = float(sys.argv[1])

print(*[round(_, 2) for _ in (i / -5, (-.08235 * i) - 30)])
