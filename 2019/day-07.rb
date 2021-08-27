require_relative './int_code_cpu'
require 'pry-byebug'

input = File.read('day-07-input.txt')

ints = input.split(',').map(&:to_i)

# part 1

def amplify(signal, config, ints)  
  config.each do |phase|
    cpu = IntCodeCpu.new(ints)
    cpu.input << phase
    cpu.input << signal
    signal = cpu.run.last
  end

  signal
end

max_signal = 0

[0,1,2,3,4].permutation.each do |config|
  signal = amplify(0, config, ints)

  max_signal = signal if signal > max_signal
end

puts "Max signal: #{max_signal}"

# part 2

def amplify_with_feedback(signal, config, ints)
  amplifiers = []
  amplifier_index = 0
  
  while true do
    cpu = amplifiers[amplifier_index]
    
    if cpu.nil?
      cpu = IntCodeCpu.new(ints)
      amplifiers[amplifier_index] = cpu

      cpu.input << config[amplifier_index]
    end

    amplifier_index = (amplifier_index + 1) % 5
    
    puts "***** amplifier # #{amplifier_index}"
    puts signal
    
    cpu.input << signal
    
    signal = cpu.run.last

    break if cpu.halted?
  end

  amplifiers.last.output
end



ints = "3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5".split(',').map(&:to_i)

config = [9,8,7,6,5]

puts amplify_with_feedback(0, config, ints)



=begin
ints = "3,52,1001,52,-5,52,3,53,1,52,56,54,1007,54,5,55,1005,55,26,1001,54,-5,54,1105,1,12,1,53,54,53,1008,54,0,55,1001,55,1,55,2,53,55,53,4,53,1001,56,-1,56,1005,56,6,99,0,0,0,0,10".split(',').map(&:to_i)

config = [9,7,8,5,6]

puts amplify_with_feedback(0, config, ints)
=end


#[5,6,7,8,9].permutation.each do |config|
  

  

#end
