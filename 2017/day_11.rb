test_input = [
  "ne,ne,ne",
  "ne,ne,sw,sw",
  "ne,ne,s,s",
  "se,sw,se,sw,sw"
]

input = File.read("input/day_11").split(',')

Struct.new("Coord", :x, :y, :z)

def next_hex(coord, move)
  case move
  when 'n'
    Struct::Coord.new(coord.x, coord.y + 1, coord.z - 1)
  when 'ne'
    Struct::Coord.new(coord.x + 1, coord.y, coord.z - 1)
  when 'se'
    Struct::Coord.new(coord.x + 1, coord.y - 1, coord.z)
  when 's'
    Struct::Coord.new(coord.x, coord.y - 1, coord.z + 1)
  when 'sw'
    Struct::Coord.new(coord.x - 1, coord.y, coord.z + 1)
  when 'nw'
    Struct::Coord.new(coord.x - 1, coord.y + 1, coord.z)
  end
end

def distance(hex_a, hex_b)
  [(hex_b.x - hex_a.x).abs, (hex_b.y - hex_a.y).abs, (hex_b.z - hex_a.z).abs].max
end

def follow(start_hex, path)
  current_hex = start_hex
  max_dist = 0
  
  path.each do |move|
    current_hex = next_hex(current_hex, move)

    dist = distance(start_hex, current_hex)
    max_dist = dist if dist > max_dist
  end

  return current_hex, max_dist
end

puts "*** Part One"

start_hex = Struct::Coord.new(0, 0, 0)

test_input.each do |path|
  finish_hex = follow(start_hex, path.split(','))[0]
  puts "#{path} => #{distance(start_hex, finish_hex)}"
end

finish_hex, max_dist = follow(start_hex, input)

puts "Answer: #{distance(start_hex, finish_hex)}"

puts "*** Part Two"

puts "Answer: #{max_dist}"
