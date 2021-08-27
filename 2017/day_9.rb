test_input_1 = {
  '{}' => 1,
  '{{{}}}' => 6,
  '{{},{}}' => 5,
  '{{{},{},{{}}}}' => 16,
  '{<a>,<a>,<a>,<a>}' => 1,
  '{{<ab>},{<ab>},{<ab>},{<ab>}}' => 9,
  '{{<!!>},{<!!>},{<!!>},{<!!>}}' => 9,
  '{{<a!>},{<a!>},{<a!>},{<ab>}}' => 3
}

test_input_2 = {
  '<>' => 0,
  '<random characters>' => 17,
  '<<<<>' => 3,
  '<{!>}>' => 2,
  '<!!>' => 0,
  '<!!!>>' => 0,
  '<{o"i!a,<{i<a>' => 10
}

input = File.read("input/day_9")

def score_stream(stream)
  total_score = 0
  garbage_count = 0
  
  current_score = 1
  garbage = false
  i = 0
  
  while i < stream.length
    char = stream[i]

    if garbage && !['>', '!'].include?(char)
      garbage_count += 1
    end
    
    case char
    when '{'
      if !garbage
        total_score += current_score
        current_score += 1
      end
    when '}'
      if !garbage
        current_score -= 1
      end
    when '<'
      if !garbage
        garbage = true
      end
    when '>'
      garbage = false
    when '!'
      i += 1
    end
    
    i += 1
  end

  return total_score, garbage_count
end

puts "*** Part One"
test_input_1.each do |k,v|
  puts "#{k} => #{score_stream(k)[0]} vs #{v}"
end
puts "Answer: #{score_stream(input)[0]}"

puts "*** Part Two"
test_input_2.each do |k,v|
  puts "#{k} => #{score_stream(k)[1]} vs #{v}"
end
puts "Answer: #{score_stream(input)[1]}"
