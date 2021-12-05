import copy
from typing import NamedTuple

with open('day-18.txt') as f:
    input = f.readlines()

with open('day-18-test.txt') as f:
    test_input = f.readlines()

### Part 1

class Coord(NamedTuple):
    x: int
    y: int

def parse_grid(input):
    grid = []
    
    for line in input:
        row = []
        
        for ch in line.strip():
            row.append(ch == '#')

        grid.append(row)

    return grid

def print_grid(grid):
    for row in grid:
        for light in row:
            if light:
                print('#', end='')
            else:
                print('.', end='')
        print()
    print()

def count_lit_neighbors(grid, x, y):
    count = 0

    for offset_x in range(-1, 2):
        for offset_y in range(-1, 2):
            if offset_x == 0 and offset_y == 0:
                continue
            
            nx = x + offset_x
            ny = y + offset_y

            if nx >= 0 and nx < len(grid[y]) and ny >= 0 and ny < len(grid) and grid[ny][nx]:
                count += 1
    
    return count

def advance_grid(grid, corners_stuck = False):
    next_grid = copy.deepcopy(grid)
  
    for y in range(0, len(grid)):
        row = grid[y]
      
        for x in range(0, len(row)):
            # Handle sticky corners for Part 2
            if corners_stuck and is_corner(grid, x, y):
                continue
            
            neighbors_lit = count_lit_neighbors(grid, x, y)
          
            if grid[y][x] and neighbors_lit not in [2, 3]:
                next_grid[y][x] = False
            elif not grid[y][x] and neighbors_lit == 3:
                next_grid[y][x] = True

    return next_grid

def simulate_grid(grid, steps, corners_stuck = False):
    new_grid = copy.deepcopy(grid)
    
    for i in range(0, steps):
        new_grid = advance_grid(new_grid, corners_stuck)

    return new_grid

def count_lights(grid):
    count = 0
    
    for row in grid:
        for light in row:
            if light:
                count += 1

    return count

test_grid = parse_grid(test_input)
future_test_grid = simulate_grid(test_grid, 4)

assert count_lights(future_test_grid) == 4

grid = parse_grid(input)
future_grid = simulate_grid(grid, 100)

print("Part 1: " + str(count_lights(future_grid)))

### Part 2

def is_corner(grid, x, y):
    return (x == 0 and y == 0
            or x == 0 and y == len(grid) - 1
            or x == len(grid[0]) - 1 and y == 0
            or x == len(grid[0]) - 1 and y == len(grid) - 1)

def turn_corners_on(grid):
    new_grid = copy.deepcopy(grid)

    new_grid[0][0] = True
    new_grid[len(grid) - 1][0] = True
    new_grid[0][len(grid[0]) - 1] = True
    new_grid[len(grid) - 1][len(grid[0]) - 1] = True

    return new_grid

test_grid = turn_corners_on(test_grid)
future_test_grid = simulate_grid(test_grid, 5, True)

assert count_lights(future_test_grid) == 17

grid = turn_corners_on(grid)
future_grid = simulate_grid(grid, 100, True)

print("Part 2: " + str(count_lights(future_grid)))
