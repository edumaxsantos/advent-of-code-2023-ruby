Red_total = 12
Green_total = 13
Blue_total = 14

def get_group(line, color)
  line.scan(/ (\d*) #{color}/).flatten.map {|c| c.to_i }
end

def beyond_limit?(group, limit)
  group.any? {|n| n > limit }
end

def valid_game?(line)
  red_groups = get_group(line, 'red')
  return false if beyond_limit?(red_groups, Red_total)

  green_groups = get_group(line, 'green')
  return false if beyond_limit?(green_groups, Green_total)

  blue_groups = get_group(line, 'blue')
  !beyond_limit?(blue_groups, Blue_total)
end

def game_id(line)
  pattern_for_id = /Game (\d*): /
  id = line.match(pattern_for_id)[1]

  return id if valid_game? line

  nil
end


lines = File.readlines('input-2.txt')

puts lines.map { |line| game_id(line).to_i }
          .inject :+