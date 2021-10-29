from typing import NamedTuple

with open('day-06.txt') as f:
    input = f.readlines()

### Part 1

class Coord(NamedTuple):
    x: int
    y: int

def str_to_coord(string):
    split = string.split(',')
    return Coord(int(split[0]), int(split[1]))

def count_lights(lights):
    count = 0
    
    for light in lights:
        if light:
            count += 1

    return count

size = 1000
lights = [ False ] * size * size

for line in input:
    split = line.split()

    from_coord = str_to_coord(split[-3])
    to_coord = str_to_coord(split[-1])

    for y in range(from_coord.y, to_coord.y + 1):
        for x in range(from_coord.x, to_coord.x + 1):
            idx = size * y + x

            if split[1] == "on":
                lights[idx] = True
            elif split[1] == "off":
                lights[idx] = False
            else:
                lights[idx] = not lights[idx]

print("Part 1: " + str(count_lights(lights)))

### Part 2

def total_brightness(lights):
    total = 0

    for light in lights:
        total += light

    return total

lights = [ 0 ] * size * size

for line in input:
    split = line.split()

    from_coord = str_to_coord(split[-3])
    to_coord = str_to_coord(split[-1])

    for y in range(from_coord.y, to_coord.y + 1):
        for x in range(from_coord.x, to_coord.x + 1):
            idx = size * y + x

            if split[1] == "on":
                lights[idx] += 1
            elif split[1] == "off":
                lights[idx] = max(0, lights[idx] - 1)
            else:
                lights[idx] += 2

print("Part 2: " + str(total_brightness(lights)))
