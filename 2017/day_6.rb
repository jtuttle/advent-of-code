require 'set'

test_input = [ 0, 2, 7, 0 ]

input = File.readlines("input/day_6")[0].split(' ').map(&:to_i)

def first_max_index(banks)
  max_index = 0
  max = banks[max_index]

  banks.each_with_index do |n, i|
    if n > max
      max_index = i
      max = banks[max_index]
    end
  end

  max_index
end

def redistribute(banks)
  max_index = first_max_index(banks)

  blocks = banks[max_index]
  banks[max_index] = 0

  index = (max_index + 1) % banks.count
  
  while blocks > 0
    banks[index] += 1
    blocks -= 1
    index = (index + 1) % banks.count
  end
end

def reallocate(banks)
  states = {}
  cycles = 0

  banks_str = banks.join(' ')

  while !states.include?(banks_str)
    before_str = banks.join(' ')
    redistribute(banks)
    banks_str = banks.join(' ')

    states[before_str] = banks_str

    cycles += 1
  end

  loop_str = states[banks_str]
  loop_cycles = 1

  while loop_str != banks_str
    loop_str = states[loop_str]
    loop_cycles += 1
  end

  return cycles, loop_cycles
end

puts "*** Part One"
puts reallocate(test_input)[0]
puts "Answer: #{reallocate(input)[0]}"

puts "*** Part Two"
puts reallocate(test_input)[1]
puts "Answer: #{reallocate(input)[1]}"

