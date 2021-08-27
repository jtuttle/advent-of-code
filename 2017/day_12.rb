require 'set'

test_input = [
  "0 <-> 2",
  "1 <-> 1",
  "2 <-> 0, 3, 4",
  "3 <-> 2, 4",
  "4 <-> 2, 3, 6",
  "5 <-> 6",
  "6 <-> 4, 5"
]

input = File.readlines("input/day_12")

def build_hash(input)
  hash = {}
  
  input.each do |line|
    line_split = line.split('<->')
    hash[line_split[0].to_i] = line_split[1].split(',').map(&:to_i)
  end

  hash
end

def find_group_member_count(hash, value, delete = false)
  group = Set.new
  visit = [value]
  
  while !visit.empty?
    next_item = visit.pop

    if !group.include?(next_item)
      group.add(next_item)
      neighbors = hash[next_item]
      hash.delete(next_item) if delete
      visit.concat(neighbors)
    end
  end

  group.count
end

def find_group_count(hash)
  group_count = 0
  
  while hash.keys.count > 0
    find_group_member_count(hash, hash.keys[0], true)
    group_count += 1
  end

  group_count
end

puts "*** Part One"

test_hash = build_hash(test_input)
input_hash = build_hash(input)

puts find_group_member_count(test_hash, 0)
puts "Answer: #{find_group_member_count(input_hash, 0)}"

puts "*** Part Two"

puts "#{find_group_count(test_hash)}"
puts "Answer: #{find_group_count(input_hash)}"
