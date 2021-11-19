import re

with open('day-16.txt') as f:
    input = f.readlines()

### Part 1

scan = {
    "children": 3,
    "cats": 7,
    "samoyeds": 2,
    "pomeranians": 3,
    "akitas": 0,
    "vizslas": 0,
    "goldfish": 5,
    "trees": 3,
    "cars": 2,
    "perfumes": 1
}

def parse_aunts(input):
    aunts = {}

    for aunt in input:
        split = re.split(': |, | ', aunt.strip())

        traits = {}
        traits[split[2]] = int(split[3])
        traits[split[4]] = int(split[5])
        traits[split[6]] = int(split[7])

        aunts[split[1]] = traits

    return aunts

def compare_aunts(scan, test_traits):
    for k in test_traits:
        if test_traits[k] != scan[k]:
            return False

    return True

def find_aunt(scan, aunts, compare_func):
    for k in aunts:
        if compare_func(scan, aunts[k]):
            return k

    raise Exception("No aunt found!")

print("Part 1: " + find_aunt(scan, parse_aunts(input), compare_aunts))

### Part 2

def compare_aunts_2(scan, test_traits):
    for k in test_traits:
        if k in ["cats", "trees"]:
            if test_traits[k] <= scan[k]:
                return False
        elif k in ["pomeranians", "goldfish"]:
            if test_traits[k] >= scan[k]:
                return False
        else:
            if test_traits[k] != scan[k]:
                return False

    return True


print("Part 2: " + find_aunt(scan, parse_aunts(input), compare_aunts_2))
