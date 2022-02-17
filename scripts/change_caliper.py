from random import choice
from math import ceil
from collections import Counter

coins = [
    ("nickel", 1.95),
    ("quarter", 1.75),
    ("penny", 1.52),
    ("dime", 1.35),
]

desired_thickness = float(input("What's your desired measure? "))

if desired_thickness < 2:
    print("nickel: 1.95mm")
    print("quarter: 1.75mm")
    print("penny: 1.52mm")
    print("dime: 1.35mm")
    print("A dollar bill is just over .1mm thick")
    exit()

#the dime is the thinnest coin and a stack of values
max_num_coins = ceil(desired_thickness / 1.35)
rounds = 1000

rankings = []
for round in range(rounds):
    coin_picks = []
    pick_sum_mm = 0
    for coin_num, coin_pick in enumerate(range(max_num_coins)):
        coin_name, thickness = choice(coins)
        coin_picks.append(coin_name)
        pick_sum_mm += thickness
        if pick_sum_mm > desired_thickness:
            break
    # find the count of each type of coin:
    counts = list(dict(Counter(coin_picks)).items())
    # sort on the second value (quantity of a particular coin):
    sorted_counts = sorted(counts, key=lambda x: x[1], reverse=True)
    rankings.append((pick_sum_mm, sorted_counts))

print("rankings:")
sorted_rankings = sorted(rankings, key=lambda x: x[0])

for item in sorted_rankings[:10]:
    thickness, counts = item
    print(thickness, counts)
