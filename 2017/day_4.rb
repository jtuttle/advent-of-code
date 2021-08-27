test_input_1 = [
  "aa bb cc dd ee",
  "aa bb cc dd aa",
  "aa bb cc dd aaa"
]

test_input_2 = [
  "abcde fghij",
  "abcde xyz ecdab",
  "a ab abc abd abf abj",
  "iiii oiii ooii oooi oooo",
  "oiii ioii iioi iiio"
]

input = File.readlines("input/day_4")

uniqueness_validator = lambda do |line|
  split_line = line.split
  split_line.uniq.count == split_line.count
end

anagram_validator = lambda do |line|
  letter_sorted = line.split(' ').map { |word|
    word.split('').map(&:ord).sort.map(&:chr).join
  }.join(' ')
  
  uniqueness_validator.call(letter_sorted)
end

def count_valid(lines, validator)
  sum = 0
  
  lines.each do |line|
#    puts "#{line} => #{validator.call(line) ? 'valid' : 'invalid'}"
    sum += 1 if validator.call(line)
  end

  sum
end

puts "*** Part One"
puts count_valid(test_input_1, uniqueness_validator)
puts "Answer: #{count_valid(input, uniqueness_validator)}"

puts "*** Part Two"
puts count_valid(test_input_2, anagram_validator)
puts "Answer: #{count_valid(input, anagram_validator)}"
