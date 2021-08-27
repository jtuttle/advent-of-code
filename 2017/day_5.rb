test_input = [0, 3, 0, 1, -3]

input = File.readlines("input/day_5").map(&:to_i)

increment_modifier = lambda do |n|
  n + 1
end

conditional_modifier = lambda do |n|
  n += (n >= 3 ? -1 : 1)
end

def process(input, modifier)
  index = 0
  steps = 0

  while index >= 0 && index < input.count
    value = input[index]
    input[index] = modifier.call(input[index])
    index += value
    steps += 1
  end

  steps
end

puts "*** Part One"
puts process(test_input.dup, increment_modifier)
puts "Answer: #{process(input.dup, increment_modifier)}"

puts "*** Part Two"
puts process(test_input.dup, conditional_modifier)
puts "Answer: #{process(input.dup, conditional_modifier)}"
