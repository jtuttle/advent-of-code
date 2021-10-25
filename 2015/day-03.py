from typing import NamedTuple

with open('day-03.txt') as f:
    input = f.readlines()

input = input[0].strip()

### Part 1

class Coord(NamedTuple):
    x: int
    y: int

def neighbor(pos, direction):
    if direction == '>':
        return Coord(pos.x + 1, pos.y)
    elif direction == 'v':
        return Coord(pos.x, pos.y + 1)
    elif direction == '<':
        return Coord(pos.x - 1, pos.y)
    elif direction == '^':
        return Coord(pos.x, pos.y - 1)
    else:
        raise NotImplementedError

def deliver(directions):
    pos = Coord(0, 0)
    visited = { pos }

    for direction in directions:
        pos = neighbor(pos, direction)
        visited.add(pos)

    return len(visited)

assert deliver(">") == 2
assert deliver("^>v<") == 4
assert deliver("^v^v^v^v^v") == 2

print("Part 1: " + str(deliver(input)))

### Part 2

def robo_deliver(directions):
    santa = Coord(0, 0)
    robo = Coord(0, 0)
    visited = { santa }

    for idx, direction in enumerate(directions):
        if idx % 2 == 0:
            santa = neighbor(santa, direction)
            visited.add(santa)
        else:
            robo = neighbor(robo, direction)
            visited.add(robo)

    return len(visited)

assert robo_deliver("^v") == 3
assert robo_deliver("^>v<") == 3
assert robo_deliver("^v^v^v^v^v") == 11

print("Part 2: " + str(robo_deliver(input)))
