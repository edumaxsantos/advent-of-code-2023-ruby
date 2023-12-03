# @param matrix [Array]
# @param positions [Array]
# @param i [Integer]
# @param j [Integer]
def has_adjacent?(matrix, positions, i, j)
  positions.any? do |position|
    x = i + position[0]
    y = j + position[1]
    #puts "x: #{x}, y: #{y}"
    #puts matrix[x][y]
    matrix[x][y] =~ /[^.\w]/
  end
end



# @param matrix [Array]
def get_numbers(matrix)
  sum = 0
  matrix.each_with_index do |line, i|
    end_of_line = line.length - 2
    num = ''
    has_adjacent = false
    puts "line ##{i+1}"
    line.each_with_index do |element, j|
      if element =~ /\d/
        num << element
      else
        if has_adjacent
          #puts num
          sum += num.to_i
        end
        num = ''
        has_adjacent = false
      end

      next if has_adjacent

      next if element == '.'

      positions = []

      is_first_line = i == 0
      is_middle_col = j != 0 && j < end_of_line
      is_first_col = j == 0

      if is_first_line
        puts "first line"
        if is_middle_col
          puts "middle of first line"
          positions = [[0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
        else
          if is_first_col
            puts "first row first line"
            positions = [[0, 1], [1, 0], [1, 1]]
          else
            puts "last row first line"
            positions = [[0, -1], [1, -1], [1, 0]]
          end
        end
      end

      is_last_line = i == matrix.length - 1

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

      is_middle_line = !is_first_line && !is_last_line

      # middle
      if is_middle_line && is_middle_col
        positions = [[-1 ,-1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
      end

      has_adjacent = has_adjacent?(matrix, positions, i, j)
    end
  end

  sum
end


lines = File.readlines('input-3.txt')

matrix = lines.map { |line| line.split('') }

puts get_numbers matrix