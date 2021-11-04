import re

with open('day-08-test.txt') as f:
    test_input = list(map(str.strip, f.readlines()))

with open('day-08.txt') as f:
    input = list(map(str.strip, f.readlines()))

### Part 1

def char_count(strings):
    count = 0

    for string in strings:
        count += len(string)
    
    return count

def decoded_count(strings):
    count = 0

    for str in strings:
        count += len(eval(str))

    return count

assert char_count(test_input) - decoded_count(test_input) == 12

char_diff = char_count(input) - decoded_count(input)

print("Part 1: " + str(char_diff))

### Part 2

def encoded_count(strings):
    count = 0

    for str in strings:
        encoded = re.sub(r"\\", r"\\\\", str)
        encoded = re.sub(r'"', r'\\"', encoded)
        encoded = "\"" + encoded + "\""
        count += len(encoded)

    return count

assert encoded_count(test_input) - char_count(test_input) == 19

char_diff = encoded_count(input) - char_count(input)

print("Part 2: " + str(char_diff))
