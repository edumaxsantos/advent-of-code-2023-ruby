def get_line_digits(line)
  first_digit = ''
  second_digit = ''
  spelled = {one: '1', two: '2', three: '3', four: '4', five: '5', six: '6', seven: '7', eight: '8', nine: '9'}

  line.each_char.with_index do |char, i|
    # fixme: will fail if char is really 0
    if char.to_i != 0
      if first_digit.empty?
        first_digit = char
        next
      end
      second_digit = char
      next
    end

    found = spelled.find { |sym, digit| line.slice(i..-1).start_with? sym.to_s }

    if found
      if first_digit.empty?
        first_digit = found[1]
        next
      end
      second_digit = found[1]
    end
  end

  return first_digit << first_digit if second_digit.empty?

  first_digit << second_digit
end


lines = File.readlines('input-1-1.txt')

p lines.map { |line| get_line_digits(line).to_i }
.inject :+
