import itertools

with open('day-13-test.txt') as f:
    test_input = f.readlines()

with open('day-13.txt') as f:
    input = f.readlines()

### Part 1

def build_relations(input):
    relations = {}
    
    for line in input:
        split = line.split()

        person = split[0]

        if person not in relations:
            relations[person] = {}
        
        neighbor = split[-1][:-1]

        happiness = int(split[3])
        if split[2] == "lose": happiness *= -1

        relations[person][neighbor] = happiness
        
    return relations

def get_happiness(seating, relations):
    happiness = 0

    for i in range(0, len(seating)):
        person = seating[i]
        neighbor_left = seating[(i - 1) % len(seating)]
        neighbor_right = seating[(i + 1) % len(seating)]

        happiness += relations[person][neighbor_left]
        happiness += relations[person][neighbor_right]

    return happiness

def get_max_happiness(relations):
    max_happiness = 0
    
    perms = list(itertools.permutations(relations.keys()))

    for perm in perms:
        happiness = get_happiness(perm, relations)
        max_happiness = max(happiness, max_happiness)

    return max_happiness

assert get_max_happiness(build_relations(test_input)) == 330

relations = build_relations(input)
max_happiness = get_max_happiness(relations)

print("Part 1: " + str(max_happiness))

### Part 2

relations["Me"] = {}

for person in relations.keys():
    if not person == "Me":
        relations["Me"][person] = 0
        relations[person]["Me"] = 0

new_happiness = get_max_happiness(relations)

print("Part 2: " + str(new_happiness))
