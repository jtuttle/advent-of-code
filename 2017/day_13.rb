test_input = [
  "0: 3",
  "1: 2",
  "4: 4",
  "6: 4"
]

input = File.readlines("input/day_13")

Struct.new("Layer", :depth, :range, :scanner_position, :scanner_direction)

def create_firewall(input)
  firewall = {}
  
  input.each do |line|
    depth, range = line.split(': ').map(&:to_i)
    firewall[depth] = Struct::Layer.new(depth, range, 0, :down)
  end

  firewall
end

def advance_firewall(firewall, steps)
  steps.times do
    firewall.each { |_,v| advance_scanner(v) }
  end
end

def save_state(firewall)
  state = {}
  
  firewall.each do |k,v|
    state[k] = [v.scanner_position, v.scanner_direction]
  end

  state
end

def load_state(firewall, state)
  state.each do |k,v|
    firewall[k].scanner_position = v[0]
    firewall[k].scanner_direction = v[1]
  end
end

def advance_scanner(layer)
  pos = layer.scanner_position
  dir = layer.scanner_direction

  if dir == :down
    if pos == layer.range - 1
      layer.scanner_position -= 1
      layer.scanner_direction = :up
    else
      layer.scanner_position += 1
    end
  elsif dir == :up
    if pos == 0
      layer.scanner_position += 1
      layer.scanner_direction = :down
    else
      layer.scanner_position -= 1
    end
  end
end

def get_severity(firewall, allow_catch = true)
  length = firewall.keys.last
  
  severity = 0
  caught = false

  position = -1

  while position <= length
    position += 1

    layer = firewall[position]

    if !layer.nil? && layer.scanner_position == 0
      severity += layer.depth * layer.range
      caught = true
      
      return severity, caught unless allow_catch
    end

    advance_firewall(firewall, 1)
  end

  return severity, caught
end

# Note: This simulation solution worked, amazingly enough, but it would probably
# have been better to come up with a solution where you compute whether each
# firewall state is passable without having to actually simulate it.
def get_min_delay(input)
  firewall = create_firewall(input)
  
  delay = 0
  success = false

  until success
    delay += 1

    advance_firewall(firewall, 1)
    state = save_state(firewall)
    
    severity, caught = get_severity(firewall, false)

    load_state(firewall, state)
    
    success = !caught
  end

  delay
end

puts "*** Part One"
puts get_severity(create_firewall(test_input))[0]
puts "Answer: #{get_severity(create_firewall(input))[0]}"

puts "*** Part Two"
puts get_min_delay(test_input)
puts "Answer: #{get_min_delay(input)}"
