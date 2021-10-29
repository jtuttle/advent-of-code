import re

with open('day-05.txt') as f:
    input = f.readlines()

### Part 1

def has_three_vowels(string):
    # OPT: slightly faster to loop and then bail as soon as you find 3
    vowels = re.findall('[aeiou]', string)
    return len(vowels) >= 3

def has_repeat(string):
    return re.search(r'((\w)\2)', string) != None
        
def does_not_have_naughty_strings(string):
    denylist = ["ab", "cd", "pq", "xy"]
    
    if any(x in string for x in denylist):
        return False

    return True

def is_nice(string):
    return has_three_vowels(string) and has_repeat(string) and does_not_have_naughty_strings(string)

assert is_nice("ugknbfddgicrmopn") == True
assert is_nice("aaa") == True
assert is_nice("jchzalrnumimnmhp") == False
assert is_nice("haegwjzuvuyypxyu") == False
assert is_nice("dvszwmarrgswjxmb") == False

nice_count = 0

for line in input:
    if is_nice(line):
        nice_count += 1

print("Part 1: " + str(nice_count))

### Part 2

def has_repeat_pair(string):
    for i in range(0, len(string)):
        pair = string[i:i+2]

        for j in range(i+2, len(string)):
            if string[j:j+2] == pair:
                return True

    return False

def has_repeat_with_gap(string):
    for i in range(0, len(string) - 2):
        if string[i] == string[i + 2]:
            return True

    return False
    
def is_nice_2(string):
    return has_repeat_pair(string) and has_repeat_with_gap(string)

assert is_nice_2("qjhvhtzxzqqjkmpb") == True
assert is_nice_2("xxyxx") == True
assert is_nice_2("uurcxstgmygtbstg") == False
assert is_nice_2("ieodomkazucvgmuy") == False

nice_count_2 = 0

for line in input:
    if is_nice_2(line):
        nice_count_2 += 1

print("Part 2: " + str(nice_count_2))
