import re
import json

with open('day-12.txt') as f:
    input = f.readlines()[0]

### Part 1

def sum_string_nums(string):
    nums = re.findall(r'[-\d]+', string)
    nums = list(map(int, nums))
    return sum(nums)

assert sum_string_nums('[1,2,3]') == 6
assert sum_string_nums('{"a":2,"b":4}') == 6
assert sum_string_nums('[[[3]]]') == 3
assert sum_string_nums('{"a":{"b":4},"c":-1}') == 3
assert sum_string_nums('{"a":[-1,1]}') == 0
assert sum_string_nums('[-1,{"a":1}]') == 0
assert sum_string_nums('[]') == 0
assert sum_string_nums('{}') == 0

print("Part 1: " + str(sum_string_nums(input)))

### Part 2

def sum_json_obj(json_obj):
    total = 0

    if isinstance(json_obj, int):
        total += json_obj
    elif isinstance(json_obj, list):
        for child in json_obj:
            total += sum_json_obj(child)
    elif isinstance(json_obj, dict):
        vals = json_obj.values()
        
        if not "red" in vals:
            for child in vals:
                total += sum_json_obj(child)
            
    return total

def sum_json_str(json_str):
    json_obj = json.loads(json_str)

    return sum_json_obj(json_obj)
    

json_obj = json.loads(input)

assert sum_json_str('[1,2,3]') == 6
assert sum_json_str('[1,{"c":"red","b":2},3]') == 4
assert sum_json_str('{"d":"red","e":[1,2,3,4],"f":5}') == 0
assert sum_json_str('[1,"red",5]') == 6

print("Part 2: " + str(sum_json_str(input)))
