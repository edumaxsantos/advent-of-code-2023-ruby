# @param line [String]
def count_matches(line)
  regex = /.*: (?<winner>.*)\s+\|\s*(?<mine>.*)/

  matched = line.match(regex)
  winners = matched['winner'].split(' ')
  mine = matched['mine'].split(' ')
  count = 0
  mine.each do |num|
    if winners.include? num
      count += 1
    end
  end

  count
end

lines = File.readlines('input.txt')

repetitions = lines.map { |line| count_matches line }

def reps(original, index)
  (index+1...index+1+original[index]).map {|n| reps(original, n) }
                                     .inject 1, :+
end

puts repetitions.map.with_index { |_, index| reps(repetitions, index) }
           .inject :+