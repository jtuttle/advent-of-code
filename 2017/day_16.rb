test_input = [
  "s1",
  "x3/4",
  "pe/b"
]

input = File.read("input/day_16").split(',')

def rotate(progs, amount)
  progs.chars.rotate(-amount).join
end

def swap_indices(progs, idx1, idx2)
  value = progs[idx1]
  progs[idx1] = progs[idx2]
  progs[idx2] = value
end

def swap_progs(progs, prog1, prog2)
  swap_indices(progs, progs.index(prog1), progs.index(prog2))
end

def dance(progs, commands)
  commands.each do |cmd|
    case cmd[0]
    when 's'
      progs = rotate(progs, cmd[1..-1].to_i)
    when 'x'
      swap_indices(progs, *cmd[1..-1].split('/').map(&:to_i))
    when 'p'
      swap_progs(progs, *cmd[1..-1].split('/'))
    end
  end
  
  progs
end

def find_cycle_length(progs, commands)
  start_progs = progs.dup

  progs = dance(progs, commands)
  count = 1

  until progs == start_progs
    progs = dance(progs, commands)
    count += 1
  end

  count
end

def long_dance(progs, commands, rounds)
  cycle_length = find_cycle_length(progs, commands)
puts "$$$ #{cycle_length}"
  (rounds % cycle_length).times do
    progs = dance(progs, commands)
  end

  progs
end

puts "*** Part One"
puts dance(('a'..'e').to_a.join, test_input)
puts "Answer: #{dance(('a'..'p').to_a.join, input)}"

puts "*** Part Two"
puts long_dance(('a'..'e').to_a.join, test_input, 1000000000)
puts "Answer: #{long_dance(('a'..'p').to_a.join, input, 1000000000)}"
