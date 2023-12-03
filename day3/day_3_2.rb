# find which indexes are adjacent
# @param matrix [Array<Array<String>>]
# @param positions [Array]
# @param i [Integer]
# @param j [Integer]
def get_adjacent(matrix, positions, i, j)
  positions.select do |position|
    x = i + position[0]
    y = j + position[1]
    #puts "x: #{x}, y: #{y}"
    #puts matrix[x][y]
    matrix[x][y] =~ /\d/
  end
end

def get_gear_ratios(matrix)
  gear_ratios = []

  matrix.each_with_index do |line, i|
    end_of_line = line.length - 2
    line.each_with_index do |element, j|
      positions = []

      is_first_line = i == 0
      is_middle_col = j != 0 && j < end_of_line
      is_first_col = j == 0
      is_last_line = i == matrix.length - 1
      is_middle_line = !is_first_line && !is_last_line

      next if element != "*"

      if is_first_line
        if is_middle_col
          positions = [[0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
        else
          if is_first_col
            positions = [[0, 1], [1, 0], [1, 1]]
          else
            positions = [[0, -1], [1, -1], [1, 0]]
          end
        end
      end

      if is_last_line
        if is_middle_col
          positions = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1]]
        else
          if is_first_col
            positions = [[-1, 0], [-1, 1], [0, 1]]
          else
            positions = [[-1, -1], [-1, 0], [0, -1]]
          end
        end
      end

      # middle
      if is_middle_line && is_middle_col
        positions = [[-1 ,-1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
      end

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

matrix = lines.map { |line| line.split('') }

puts get_gear_ratios(matrix).inject :+