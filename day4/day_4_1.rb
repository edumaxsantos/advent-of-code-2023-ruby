def get_points(line)
  regex = /.*: (?<winner>.*)\s+\|\s*(?<mine>.*)/

  matched = line.match(regex)
  winners = matched['winner'].split(' ')
  mine = matched['mine'].split(' ')
  count = 0
  mine.each do |num|
    if winners.include? num
      if count == 0
        count = 1
      else
        count *= 2
      end
    end
  end

  count
end

lines = File.readlines('input.txt')

puts lines.map {|line| get_points line }
     .inject :+