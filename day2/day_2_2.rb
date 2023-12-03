def multiply_max_for_each_color(line)
  pattern_for_red = / (\d*) red/
  pattern_for_green = / (\d*) green/
  pattern_for_blue = / (\d*) blue/
  red_groups = line.scan(pattern_for_red).flatten.map {|c| c.to_i }
  red = red_groups.max

  green_groups = line.scan(pattern_for_green).flatten.map {|c| c.to_i }
  green = green_groups.max


  blue_groups = line.scan(pattern_for_blue).flatten.map {|c| c.to_i }
  blue = blue_groups.max

  red * green * blue
end

lines = File.readlines('input-2.txt')

puts lines.map { |line| multiply_max_for_each_color(line) }
          .inject :+