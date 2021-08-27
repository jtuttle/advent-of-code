input = File.open('day-01-input.txt').readlines

### part 1

def fuel_required(mass)
  mass / 3 - 2
end

sum = input.map { |line| fuel_required(line.to_i) }.sum

puts "Total fuel (part 1): #{sum}"

### part 2

def actual_fuel_required(mass)
  total_fuel = 0

  while mass > 0
    fuel = fuel_required(mass)
    total_fuel += fuel if fuel > 0
    mass = fuel
  end
  
  total_fuel
end

sum = input.map { |line| actual_fuel_required(line.to_i) }.sum

puts "Total fuel (part 2): #{sum}"
