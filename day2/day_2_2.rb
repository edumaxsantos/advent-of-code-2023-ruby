def get_group(line, color)
  line.scan(/ (\d*) #{color}/).flatten.map {|c| c.to_i }
end

def multiply_max_for_each_color(line)
  red_groups = get_group(line, 'red')
  red = red_groups.max

  green_groups = get_group(line, 'green')
  green = green_groups.max


  blue_groups = get_group(line, 'blue')
  blue = blue_groups.max

  red * green * blue
end

lines = File.readlines('input-2.txt')

puts lines.map { |line| multiply_max_for_each_color(line) }
          .inject :+