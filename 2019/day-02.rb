require_relative './int_code_cpu'

input = File.read('day-02-input.txt')

### part 1

ints = input.split(',').map(&:to_i)
ints[1] = 12
ints[2] = 2

IntCodeCpu.new(ints).run

puts "Position zero (part 1): #{ints[0]}"

### part 2

(0...99).each do |noun|
  (0...99).each do |verb|
    ints = input.split(',').map(&:to_i)
    ints[1] = noun
    ints[2] = verb

    IntCodeCpu.new(ints).run

    if ints[0] == 19690720
      puts "100 * noun + verb (part 2): #{100 * noun + verb}"
    end
  end
end
