from random import sample # pick n cards from a full shuffled deck
from random import choice # pick one random card, put it back in the deck

numbers = ('2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A')

suits = ('♠', '♥', '♣', '♦')

deck = []

#enumerate allows us to step through "numbers" with an incrementing index:
#inside the curly brackets we're doing a dictionary comprehension:
card_vals = {number:index + 1 for index, number in enumerate(numbers)}

print(card_vals)

for number in numbers:
    for suit in suits:
        card = (card_vals[number], number, suit)
        deck.append(card) #(number string, suit string, value of card)

for run in range(5): #5 here is how many times we're repeating the below loop
    hand = sample(deck, 6) #6 here is how many cards we're pulling
    #each card is a tuple of three values of type (int, str, str)
    hand_val = sum([card[0] for card in hand])
    print(f'hand: {hand}, hand sum: {hand_val}')
    #the zero after the lambda here means that we're sorting on the first element of the tuple:
    #the lambda is just a temporary nameless function we use to return something trivial
    sorted_hand = sorted(hand, key=lambda x: x[0])
    #take just the lowest three:
    print("just the first three:", sorted_hand[:3])
    #inside sum (line 37) I'm doing a list comprehension: it's enclosed in some square brackets
    #   what we make a list of is before the 'for'
    #   in this case it's the first (zeroth?) item of our card
    #   'card' is what we're calling each item (between 'for' and 'in')
    #   after the 'in' is what we're looping over, 
    #       sorted_hand[:3] means we're taking a slice of sorted_hand up to but not including the third element
    sum_of_three_lowest = sum([card[0] for card in sorted_hand[:3]])
    print(f"sum of the lowest three:{sum_of_three_lowest}")

#print statements are super slow, so when doing a bunch of something, we'll want to comment them out with a '#'

#so let's do that again without the fluff, and keep track of our results:

print('----------------------------------------------------------------------------')
print('okay, actually running the interesting stuff now:\n')

#keep our results in a dictionary:
results = {
    'less than 10':0,
    'more than 10':0,
} 

runs = 1000000
hand_size = 6
sum_from_n = 3 #this is the number of lowest-valued cards we're summing

for run in range(runs):
    hand = sample(deck, hand_size)
    #the below line is taking the sum of the hand, we don't need it:
    #hand_val = sum([card[0] for card in hand]) 
    sorted_hand = sorted(hand, key=lambda x: x[0])
    sum_of_three_lowest = sum([card[0] for card in sorted_hand[:sum_from_n]])
    if sum_of_three_lowest < 10:
        results['less than 10'] += 1
    else:
        results['more than 10'] += 1
    #every 100000 runs, give us an update:
    if run % 100000 == 0:
        print(f'run: {run}')

print(f'results: {results}')

