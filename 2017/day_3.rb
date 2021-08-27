# 6 5 4 3 4 5 6
# 5 4 3 2 3 4 5
# 4 3 2 1 2 3 4
# 3 2 1 0 1 2 3
# 4 3 2 1 2 3 4
# 5 4 3 2 3 4 5
# 6 5 4 3 4 5 6

# 1   2 3 4 5 6 7 8 9   10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25   26 27 28 29 30 31 32 ...
# 0   1 2 1 2 1 2 1 2   3  2  3  4  3  2  3  4  3  2  3  4  3  2  3  4    5  4  3  4  5  6  5  ...

test_input_1 = [
  1, 12, 23, 1024
]

input = 361527

def next_odd_square(num)
  odd_num = 1
  
  while odd_num ** 2 < num
    odd_num += 2
  end

  odd_num
end

def distance(num)
  nos = next_odd_square(num)
  br_corner_val = nos ** 2

  closest_axis = last_axis = br_corner_val - (nos / 2)
  closest_dist = (num - last_axis).abs
  
  (1..3).each do
    last_axis = last_axis - (nos - 1)
    
    if (num - last_axis).abs < closest_dist
      closest_dist = (num - last_axis).abs
      closest_axis = last_axis
    end
  end

  axis_dist = nos / 2
  input_dist = axis_dist + (closest_axis - num).abs

  input_dist
end

def get_coord(current, direction)
  x,y = current.split(',').map(&:to_i)

  case direction
  when :right
    "#{x+1},#{y}"
  when :up
    "#{x},#{y+1}"
  when :left
    "#{x-1},#{y}"
  when :down
    "#{x},#{y-1}"
  end 
end

def stored_value(num)
  stored_value = 0

  values = { "0,0" => 1 }
  direction = :right
  next_coord = "1,0"
  
  while stored_value < num
    x,y = next_coord.split(',').map(&:to_i)
    sum = 0

    (-1..1).each do |x_diff|
      (-1..1).each do |y_diff|
        neighbor_coord = "#{x + x_diff},#{y + y_diff}"
        sum += values[neighbor_coord] || 0
      end
    end

    values[next_coord] = sum

    case direction
    when :right
      direction = :up if values[get_coord(next_coord, :up)].nil?
    when :up
      direction = :left if values[get_coord(next_coord, :left)].nil?
    when :left
      direction = :down if values[get_coord(next_coord, :down)].nil?
    when :down
      direction = :right if values[get_coord(next_coord, :right)].nil?
    end

    next_coord = get_coord(next_coord, direction)

    stored_value = sum
  end

  stored_value
end

puts "*** Part One"
test_input_1.each do |n|
  puts "#{n} => #{distance(n)}"
end
puts "Answer: #{distance(input)}"

puts "*** Part Two"
puts "Answer: #{stored_value(361527)}"
