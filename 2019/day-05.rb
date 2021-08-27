require_relative './int_code_cpu'

input = File.read('day-05-input.txt')

### part 1

ints = input.split(',').map(&:to_i)

cpu = IntCodeCpu.new(ints)
cpu.input << 1
output = cpu.run until cpu.halted?

puts "Diagnostic code (part 1): #{output.last}"

### part 2

ints = input.split(',').map(&:to_i)

cpu = IntCodeCpu.new(ints)
cpu.input << 5
output = cpu.run until cpu.halted?

puts "Diagnostic code (part 2): #{output.last}"
