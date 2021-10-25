with open('day-02.txt') as f:
    input = f.readlines()

### Part 1
    
def split_dimensions(dimensions):
    return [int(s) for s in dimensions.split("x")]
    
def area_of_sides(dimensions):
    l, w, h = split_dimensions(dimensions)

    return [l * w, w * h, h * l]
    
def wrapping_paper(dimensions):
    sides = area_of_sides(dimensions)

    return sum(2 * sides) + min(sides)

assert wrapping_paper("2x3x4") == 58
assert wrapping_paper("1x1x10") == 43

total_wrapping_paper = 0

for line in input:
    total_wrapping_paper += wrapping_paper(line)

print("Part 1: " + str(total_wrapping_paper))

### Part 2

def ribbon(dimensions):
    sides = split_dimensions(dimensions)
    sides.sort()

    return (2 * sides[0]) + (2 * sides[1]) + (sides[0] * sides[1] * sides[2])

assert ribbon("2x3x4") == 34
assert ribbon("1x1x10") == 14

total_ribbon = 0

for line in input:
    total_ribbon += ribbon(line)

print("Part 2: " + str(total_ribbon))
