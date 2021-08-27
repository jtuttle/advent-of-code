test_input = [
  "5 1 9 5",
  "7 5 3",
  "2 4 6 8"
]

test_input_2 = [
  "5 9 2 8",
  "9 4 7 3",
  "3 8 6 5"
]

input = File.readlines("input/day_2")

def compute_checksum(lines, operation)
  lines.map { |line|
    sorted_line = line.split.map(&:to_i).sort
    operation.call(sorted_line)
  }.sum
end

line_diff = lambda do |line|
  line[-1] - line[0]
end

line_div = lambda do |line|
  line = line.uniq.reverse.map(&:to_f)

  line.each_with_index do |num, i|
    line[i+1..-1].each do |other|
      div = num / other
      return div if div % 1 == 0
    end
  end
end

puts "*** Part One"
puts "Test checksum: #{compute_checksum(test_input, line_diff)}"
puts "Input checksum: #{compute_checksum(input, line_diff)}"

puts "*** Part Two"
puts "Test checksum: #{compute_checksum(test_input_2, line_div)}"
puts "Input checksum: #{compute_checksum(input, line_div)}"
