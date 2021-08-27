test_input = [
  "b inc 5 if a > 1",
  "a inc 1 if b < 5",
  "c dec -10 if a >= 1",
  "c inc -20 if c == 10"
]

input = File.readlines("input/day_8")

def process(input)
  registers = {}
  global_max = 0
  
  input.each do |line|
    action, conditional = line.split(' if ')
    target, operation, amount = action.split
    c_target, c_operation, c_amount = conditional.split

    registers[target] = 0 unless registers.include?(target)
    registers[c_target] = 0 unless registers.include?(c_target)

    if registers[c_target].send(c_operation, c_amount.to_i)
      registers[target] += amount.to_i * (operation == 'inc' ? 1 : -1)
      global_max = registers[target] if registers[target] > global_max
    end
  end

  return registers.values.max, global_max
end

puts "*** Part One"
puts process(test_input)[0]
puts "Answer: #{process(input)[0]}"

puts "*** Part Two"
puts process(test_input)[1]
puts "Answer: #{process(input)[1]}"
