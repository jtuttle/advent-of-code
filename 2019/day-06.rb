input = File.open('day-06-input.txt').readlines

orbits = {}

input.each do |orbit|
  parent,child = orbit.split(')')
  orbits[child.strip] = parent
end

# part 1

def count_orbits(orbits)
  orbit_count = 0
  
  orbits.keys.each do |key|
    while key != "COM"
      orbit_count += 1
      key = orbits[key]
    end
  end

  orbit_count
end

puts "Total orbits (part 1): #{count_orbits(orbits)}"

# part 2

def path_to_com(orbits, object)
  path = []

  next_obj = object
  
  while next_obj != "COM"
    next_obj = orbits[next_obj]
    path << next_obj
  end
  
  path
end

def find_first_common_ancestor(path_1, path_2)
  path_1.each do |object|
    return object if path_2.include?(object)
  end
end

def count_transfers(orbits, object_1, object_2)
  path_1 = path_to_com(orbits, object_1)
  path_2 = path_to_com(orbits, object_2)

  ancestor = find_first_common_ancestor(path_1, path_2)

  path_1.find_index(ancestor) + path_2.find_index(ancestor)
end
  
puts "Total transfers (part 2): #{count_transfers(orbits, 'YOU', 'SAN')}"
