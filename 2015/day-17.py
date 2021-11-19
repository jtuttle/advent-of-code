import itertools

with open('day-17-test.txt') as f:
    test_input = f.readlines()

test_input = [int(s) for s in test_input]

with open('day-17.txt') as f:
    input = f.readlines()

input = [int(s) for s in input]
    
### Part 1

def all_combinations(input, target):
    all_combos = []
    
    for i in range(1, len(input) + 1):
        combos = list(itertools.combinations(input, i))

        for combo in combos:
            if sum(list(combo)) == target:
                all_combos.append(combo)

    return all_combos

assert len(all_combinations(test_input, 25)) == 4

combos = all_combinations(input, 150)

print("Part 1: " + str(len(combos)))

### Part 2

def min_length(combos):
    min_length = 9999

    for combo in combos:
        length = len(combo)
        min_length = min(length, min_length)
    
    return min_length

min_length = min_length(combos)
min_length_combos = list(filter(lambda combo: len(combo) == min_length, combos))

print("Part 2: " + str(len(min_length_combos)))
