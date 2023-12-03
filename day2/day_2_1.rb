Red_total = 12
Green_total = 13
Blue_total = 14

lines = [
  'Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green',
  'Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue',
  'Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red',
  'Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red',
  'Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green'
]


def valid_game?(line)
  pattern_for_red = / (\d*) red/
  pattern_for_green = / (\d*) green/
  pattern_for_blue = / (\d*) blue/
  red_groups = line.scan(pattern_for_red).flatten
  return false if red_groups.any? {|n| n.to_i > Red_total }

  green_groups = line.scan(pattern_for_green).flatten
  return false if green_groups.any? {|n| n.to_i > Green_total }

  blue_groups = line.scan(pattern_for_blue).flatten
  !blue_groups.any? {|n| n.to_i > Blue_total }
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