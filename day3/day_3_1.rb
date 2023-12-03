# @param matrix [Array]
# @param positions [Array]
# @param i [Integer]
# @param j [Integer]
def has_adjacent?(matrix, positions, i, j)
  positions.any? do |position|
    x = i + position[0]
    y = j + position[1]
    matrix[x][y] =~ /[^.\w]/
  end
end

# @param matrix [Array<Array<String>>]
def get_numbers(matrix)
  sum = 0
  matrix.each_with_index do |line, i|
    num = ''
    has_adjacent = false

    next unless line.join('').match? /[^.]/

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

      positions = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]
      has_adjacent = has_adjacent?(matrix, positions, i, j)
    end
  end

  sum
end

lines = File.readlines('input-3.txt')
size = lines[0].size

# add first empty row
matrix = [Array.new(size + 2) { |i| '.' }]

matrix += lines.map { |line| ['.'] + line.strip.split('') + ['.'] }

# add last empty row
matrix += [Array.new(size + 2) { |i| '.' }]

puts get_numbers matrix