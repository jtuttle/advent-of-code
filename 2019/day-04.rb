input = File.open('day-04-input.txt').read

### part 1

def has_double?(digits)
  for i in (0...digits.count - 1) do
    return true if digits[i] == digits[i+1]
  end

  false
end

def increasing?(digits)
  for i in (0...digits.count - 1) do
    return false if digits[i] > digits[i+1]
  end

  return true
end

def valid_password?(num)
  digits = num.digits.reverse
  has_double?(digits) && increasing?(digits)
end

range = input.split('-').map(&:to_i)

valid_count = 0

(range[0]..range[1]).each do |num|
  valid_count += 1 if valid_password?(num)  
end

puts "Valid passwords (part 1): #{valid_count}"

### part 2

def has_explicit_double?(digits)
  for i in (0...digits.count - 1) do
    if digits[i-1] != digits[i] && digits[i] == digits[i+1] && digits[i] != digits[i+2]
      return true
    end
  end

  false
end

def valid_password_2?(num)
  digits = num.digits.reverse
  has_explicit_double?(digits) && increasing?(digits)
end

valid_count = 0

(range[0]..range[1]).each do |num|
  if valid_password_2?(num)
    valid_count += 1
  end
end

puts "Valid passwords (part 2): #{valid_count}"

