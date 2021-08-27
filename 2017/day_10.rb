require_relative 'helpers/knot_hash'

test_input_1 = [3, 4, 1, 5]

test_input_2 = {
  '' => 'a2582a3a0e66e6e86e3812dcb672a272',
  'AoC 2017' => '33efeb34ea91902bb2f59c9920caa6cd',
  '1,2,3' => '3efbe78a8d82f29979031a4aa0b16a9d',
  '1,2,4' => '63960835bcdc130f0b66d7ff4f6a5a8e'
}

input = File.read("input/day_10")

def process_round(list, lengths, pos, skip)
  lengths.each do |length|
    first_index = pos
    last_index = pos + length - 1
    
    while first_index < last_index do
      first_value = list[first_index % list.length]
      list[first_index % list.length] = list[last_index % list.length]
      list[last_index % list.length] = first_value

      first_index += 1
      last_index -= 1
    end
    
    pos += length + skip
    skip += 1
  end

  return pos, skip
end

def process(list, lengths, rounds)
  pos = skip = 0
  
  rounds.times do
    pos,skip = process_round(list, lengths, pos, skip)
  end

  dense_hash = []

  list.each_slice(16) do |slice|
    dense_hash << slice.reduce(:^)
  end

  dense_hash.map { |n| "#{n < 16 ? '0' : ''}#{n.to_s(16)}" }.join
end

puts "*** Part One"

test_list = Array(0..4)
process(test_list, test_input_1, 1)
puts test_list[0] * test_list[1]

input_list = Array(0..255)
process(input_list, input.split(',').map(&:to_i), 1)
puts "Answer: #{input_list[0] * input_list[1]}"

puts "*** Part Two"

test_input_2.each do |k, v|
  test_hash = KnotHash.compute(k)
  puts "#{v} - #{test_hash} - #{v == test_hash}"
end

puts "Answer: #{KnotHash.compute(input)}"
