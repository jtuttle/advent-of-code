input = File.open('day-03-input.txt').readlines

Coord = Struct.new(:x, :y)

### part 1

def next_coord(coord, step)
  case step[0]
  when 'L'
    Coord.new(coord.x - 1, coord.y)
  when 'R'
    Coord.new(coord.x + 1, coord.y)
  when 'U'
    Coord.new(coord.x, coord.y + 1)
  when 'D'
    Coord.new(coord.x, coord.y - 1)
  end
end

def plot_wire(wire)
  coords = [Coord.new(0, 0)]
  
  wire.split(',').each do |step|
    step[1..].to_i.times do
      coords << next_coord(coords.last, step)
    end
  end

  coords
end

def find_closest_intersection(intersections)
  origin = Coord.new(0, 0)
  intersections.sort! { |a,b| manhattan(origin, a) <=> manhattan(origin, b) }
  intersections.first
end

def manhattan(coord_1, coord_2)
  (coord_1.x - coord_2.x).abs + (coord_1.y - coord_2.y).abs
end

paths = input.map { |wire| plot_wire(wire) }
intersections = (paths[0] & paths[1])[1..]
closest_intersection = find_closest_intersection(intersections)
closest_distance = manhattan(Coord.new(0, 0), closest_intersection)

puts "Closest intersection distance (part 1): #{closest_distance}"

### part 2

def count_steps(path, intersections)
  intersections.map do |intersection|
    path.find_index(intersection)
  end
end

step_counts = paths.map { |path| count_steps(path, intersections) }
step_sums = step_counts.transpose.map { |x| x.reduce(:+) }

puts "Minimum steps to intersection (part 2): #{step_sums.min}"
