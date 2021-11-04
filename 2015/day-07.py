with open('day-07-test.txt') as f:
    test_input = f.readlines()

with open('day-07.txt') as f:
    input = f.readlines()

### Part 1

def build_circuit(input):
    circuit = {}

    for line in input:
        split = line.split(" -> ")
        
        circuit[split[1].strip()] = split[0]
    
    return circuit

def evaluate(circuit, val):
    if isinstance(val, int) or val.isnumeric():
        return int(val)
    
    expr = circuit[val]

    if isinstance(expr, int) or expr.isnumeric():
        circuit[val] = int(expr)
        return int(expr)
    
    split = expr.split()

    if len(split) == 1:
        circuit[val] = evaluate(circuit, split[0])
    elif len(split) == 2: # NOT
        circuit[val] = ~evaluate(circuit, split[1]) % 65536
    elif len(split) == 3:
        if split[1] == "AND":
            circuit[val] = evaluate(circuit, split[0]) & evaluate(circuit, split[2])
        elif split[1] == "OR":
            circuit[val] = evaluate(circuit, split[0]) | evaluate(circuit, split[2])
        elif split[1] == "LSHIFT":
            circuit[val] = evaluate(circuit, split[0]) << evaluate(circuit, split[2])
        elif split[1] == "RSHIFT":
            circuit[val] = evaluate(circuit, split[0]) >> evaluate(circuit, split[2])

    return circuit[val]

test_circuit = build_circuit(test_input)

assert evaluate(test_circuit, "d") == 72
assert evaluate(test_circuit, "e") == 507
assert evaluate(test_circuit, "f") == 492
assert evaluate(test_circuit, "g") == 114
assert evaluate(test_circuit, "h") == 65412
assert evaluate(test_circuit, "i") == 65079
assert evaluate(test_circuit, "x") == 123
assert evaluate(test_circuit, "y") == 456
        
circuit = build_circuit(input)

signal_a = evaluate(circuit, "a")

print("Part 1: " + str(signal_a))

### Part 2

circuit = build_circuit(input)

circuit["b"] = signal_a

print("Part 2: " + str(evaluate(circuit, "a")))
