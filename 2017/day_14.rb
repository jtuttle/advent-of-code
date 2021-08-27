require 'set'
require_relative 'helpers/knot_hash'

test_input = "flqrgnkx"

input = "ljoxqyyw"

Struct.new("Coord", :x, :y)

def count_used(disk)
  used = 0

  disk.each do |row|
    used += row.count('1')
  end

  used
end

def create_disk(input)
  disk = []

  (0..127).each do |row|
    row_input = "#{input}-#{row}"

    hex = KnotHash.compute(row_input)
    binary = '%0128b' % hex.to_i(16)

    disk << binary.split('')
  end

  disk
end

def cell_counted?(x, y, regions)
  coord = Struct::Coord.new(y, x)
  
  regions.each do |region|
    return true if region.include?(coord)
  end

  false
end

def cell_key(row, col)
  "#{row},#{cell}"
end

def grab_region(disk, row, col)
  region = Set.new
  
  visit = [Struct::Coord.new(col, row)]

  until visit.empty?
    next_coord = visit.pop
    region.add(next_coord)

    [[0, 1], [1, 0], [0, -1], [-1, 0]].each do |delta|
      nx = next_coord.x - delta[0]
      ny = next_coord.y - delta[1]

      next if nx < 0 || nx > 127 || ny < 0 || ny > 127

      coord = Struct::Coord.new(nx, ny)

      if disk[coord.y][coord.x] == '1' && !region.include?(coord)
        visit << coord
      end
    end
  end

  region
end

def count_regions(disk)
  regions = []

  (0..127).each do |row|
    (0..127).each do |col|
      next if disk[row][col] == '0'
      
      unless cell_counted?(row, col, regions)
        regions << grab_region(disk, row, col)
      end
    end
  end

  regions.count
end

test_disk = create_disk(test_input)
disk = create_disk(input)

puts "*** Part One"
puts count_used(test_disk)
puts "Answer: #{count_used(disk)}"

puts "*** Part Two"
puts count_regions(test_disk)
puts "Answer: #{count_regions(disk)}"
