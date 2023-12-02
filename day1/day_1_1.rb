

def get_line_digits(line)
  first_digit = ''
  second_digit = ''

  line.each_char do |char|
    # fixme: if digit is 0, this won't work
    if char.to_i != 0
      if first_digit.empty?
        first_digit = char
      end
      second_digit = char
    end
  end

  first_digit << second_digit
end


lines = File.readlines('input-1-1.txt')

puts lines.map { |line| get_line_digits(line).to_i }
     .inject :+