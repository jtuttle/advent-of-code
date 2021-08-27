test_input = [65, 8921]

input = [634, 301]

class Generator
  attr_reader :current
  
  def initialize(seed, factor, divisor = 1)
    @current = seed
    @factor = factor
    @divisor = divisor
  end

  def next
    generate_next

    while @current % @divisor != 0
      generate_next
    end

    @current
  end

  private

  def generate_next
    @current *= @factor
    @current = @current % 2147483647
  end
end

def count_matches(steps, seed_a, seed_b, div_a = 1, div_b = 1)
  matches = 0
  
  gen_a = Generator.new(seed_a, 16807, div_a)
  gen_b = Generator.new(seed_b, 48271, div_b)

  steps.times do
    val_a = gen_a.next
    val_b = gen_b.next

    if val_a & 65535 == val_b & 65535
      matches += 1
    end
  end

  matches
end

puts "*** Part One"
puts count_matches(5, test_input[0], test_input[1])
puts "Answer: #{count_matches(40000000, input[0], input[1])}"

puts "*** Part Two"
puts count_matches(5, test_input[0], test_input[1], 4, 8)
puts "Answer: #{count_matches(5000000, input[0], input[1], 4, 8)}"
