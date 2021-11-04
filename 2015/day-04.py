import hashlib
import itertools

input = "bgvyzdsv"

### Part 1

def find_md5_num(key, prefix_zero_count):
    prefix = '0' * prefix_zero_count
    
    for i in itertools.count():
        test = (key + str(i)).encode('utf-8')
        md5 = hashlib.md5(test).hexdigest()

        if md5.startswith(prefix):
            return i
        
assert find_md5_num("abcdef", 5) == 609043
assert find_md5_num("pqrstuv", 5) == 1048970

print("Part 1: " + str(find_md5_num(input, 5)))

### Part 2

print("Part 2: " + str(find_md5_num(input, 6)))
