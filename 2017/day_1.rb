test_inputs_p1 = [
  "1122",
  "1111",
  "1234",
  "91212129"
]

test_inputs_p2 = [
  "1212",
  "1221",
  "123425",
  "123123",
  "12131415"
]

input = File.readlines("input/day_1")[0]

def next_match_sum(captcha, gap)
  sum = 0

  captcha_split = captcha.split('')
  
  captcha_split.each_with_index do |n, i|
    if captcha_split[i] == captcha_split[(i + gap) % captcha_split.count]
      sum += n.to_i
    end
  end

  return sum
end

puts "*** Part One" 

puts "Tests:"

test_inputs_p1.each do |ti|
  puts "#{ti} => #{next_match_sum(ti, 1)}"
end

puts "Actual: #{next_match_sum(input, 1)}"

puts "*** Part Two"

test_inputs_p2.each do |ti|
  puts "#{ti} => #{next_match_sum(ti, ti.length / 2)}"
end

puts "Actual: #{next_match_sum(input, input.length / 2)}"
