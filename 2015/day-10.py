input = "1113122113"

### Part 1

def expand(string):
    count = 1
    expansion = ""
    
    for i in range(1, len(string) + 1):
        if i >= len(string) or string[i-1] != string[i]:
            expansion += str(count) + string[i-1]
            count = 0

        count += 1

    return expansion

def repeat_expand(string, count):
    output = string
    
    for i in range(0, count):
        output = expand(output)

    return output

assert repeat_expand("1", 5) == "312211"

expansion = repeat_expand(input, 40)

print("Part 1: " + str(len(expansion)))

### Part 2

expansion = repeat_expand(expansion, 10)

print("Part 2: " + str(len(expansion)))
