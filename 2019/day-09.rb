require_relative './int_code_cpu'

input = File.read('day-09-input.txt').strip

ints = input.split(',').map(&:to_i)

# part 1

cpu = IntCodeCpu.new(ints)
cpu.input << 1

puts "BOOST keycode: #{cpu.run.last}"

# part 2

cpu = IntCodeCpu.new(ints)
cpu.input << 2

puts "coordinates: #{cpu.run.last}"
