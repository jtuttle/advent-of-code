input = File.read('day-08-input.txt')

# part 1

width = 25
height = 6

def read_layers(chars, width, height)
  layers = []
  
  while !chars.empty?
    layer = []
    
    (0...height).each do |y|
      (0...width).each do |x|
        layer << chars.shift
      end
    end

    layers << layer
  end

  layers
end

def min_zero_layer(layers)
  min_zero_layer = nil
  min_zero_count = Float::INFINITY

  layers.each do |layer|
    if min_zero_layer.nil?
      min_zero_layer = layer
      min_zero_count = layer.count('0')
    else
      zero_count = layer.count('0')

      if zero_count < min_zero_count
        min_zero_layer = layer
        min_zero_count = zero_count
      end
    end
  end
  
  min_zero_layer
end

def compute_checksum(layers)
  min_zero_layer = min_zero_layer(layers)
  min_zero_layer.count('1') * min_zero_layer.count('2')
end

chars = input.strip.split('')

layers = read_layers(chars, width, height)

puts "Checksum (part 1): #{compute_checksum(layers)}"

# part 2

def get_pixel_color(values)
  values.each do |value|
    return value if value != '2'
  end

  StandardError.new("Totally transparent layer!")
end

def combine_layers(layers)
  image = []

  (0...layers[0].count).each do |i|
    layer_values = layers.map { |layer| layer[i] }
    image << get_pixel_color(layer_values)
  end
  
  image
end

def print_image(image, width, height)
  (0...height).each do |y|
    (0...width).each do |x|
      index = width * y + x
      value = image[index]
      char = (value == '1' ? 'O' : ' ')
      print(char)
    end
    
    puts
  end
end

image = combine_layers(layers)

puts "Image (part 2):"
print_image(image, width, height)
