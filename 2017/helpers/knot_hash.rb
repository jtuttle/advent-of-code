class KnotHash
  class << self
    def compute(input)
      lengths = input.split('').map(&:ord) + [17, 31, 73, 47, 23]
      process(Array(0..255), lengths, 64)
    end

    private

    def process_round(list, lengths, pos, skip)
      lengths.each do |length|
        first_index = pos
        last_index = pos + length - 1
        
        while first_index < last_index do
          first_value = list[first_index % list.length]
          list[first_index % list.length] = list[last_index % list.length]
          list[last_index % list.length] = first_value

          first_index += 1
          last_index -= 1
        end
        
        pos += length + skip
        skip += 1
      end

      return pos, skip
    end

    def process(list, lengths, rounds)
      pos = skip = 0
      
      rounds.times do
        pos,skip = process_round(list, lengths, pos, skip)
      end

      dense_hash = []

      list.each_slice(16) do |slice|
        dense_hash << slice.reduce(:^)
      end

      dense_hash.map { |n| "#{n < 16 ? '0' : ''}#{n.to_s(16)}" }.join
    end
  end
end
