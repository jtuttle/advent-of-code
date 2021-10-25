with open('day-01.txt') as f:
    input = f.readlines()

input = input[0].strip()

### Part 1

def find_floor(directions):
    # Not as efficient as a single loop, but so succinct and still linear
    return directions.count('(') - directions.count(')')

assert find_floor("(())") == 0
assert find_floor("()()") == 0
assert find_floor("(((") == 3
assert find_floor("(()(()(") == 3
assert find_floor("))(((((") == 3
assert find_floor("())") == -1
assert find_floor("))(") == -1
assert find_floor(")))") == -3
assert find_floor(")())())") == -3

print("Part 1: " + str(find_floor(input)))

### Part 2

def find_basement_step(directions):
    floor = 0
    
    for idx, char in enumerate(directions):
        if char == '(':
            floor += 1
        elif char == ')':
            floor -= 1
        else:
            raise NotImplementedError

        if floor == -1:
            return idx + 1

assert find_basement_step(")") == 1
assert find_basement_step("()())") == 5

print("Part 2: " + str(find_basement_step(input)))
