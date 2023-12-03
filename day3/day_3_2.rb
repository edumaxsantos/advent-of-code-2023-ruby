# find which indexes are adjacent
# @param matrix [Array<Array<String>>]
# @param positions [Array]
# @param i [Integer]
# @param j [Integer]
def get_adjacent(matrix, positions, i, j)
  positions.select do |position|
    x = i + position[0]
    y = j + position[1]
    matrix[x][y] =~ /\d/
  end
end

def get_gear_ratios(matrix)
  gear_ratios = []

  matrix.each_with_index do |line, i|
    line.each_with_index do |element, j|
      positions = []

      next if element != "*"

      positions = [[-1 ,-1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]

      adjacent_matrix = get_adjacent(matrix, positions, i, j)

      # @type [Array<Array>]
      real_indexes = adjacent_matrix.map { |e| [i + e[0], j + e[1]]}

      gears_found = Set.new

      real_indexes.each do |real_index|
        real_x = real_index[0]
        real_y = real_index[1]

        num = matrix[real_x][real_y]
        previous = matrix[real_x][real_y - 1]
        y_helper = real_y - 1
        while (matched = previous.match(/\d/))
          num = matched[0] << num
          y_helper -= 1
          previous = matrix[real_x][y_helper]
        end

        nxt = matrix[real_x][real_y + 1]
        y_helper = real_y + 1
        while (matched = nxt.match(/\d/))
          num += matched[0]
          y_helper += 1
          nxt = matrix[real_x][y_helper]
        end

        gears_found << num

      end

      next if gears_found.length < 2

      gear_ratios << gears_found.map {|c| c.to_i }.inject(:*)

    end
  end

  gear_ratios
end

lines = File.readlines('input-3.txt')
size = lines[0].size

# add first empty row
matrix = [Array.new(size + 2) { |i| '.' }]

matrix += lines.map { |line| ['.'] + line.strip.split('') + ['.'] }

# add last empty row
matrix += [Array.new(size + 2) { |i| '.' }]

puts get_gear_ratios(matrix).inject :+