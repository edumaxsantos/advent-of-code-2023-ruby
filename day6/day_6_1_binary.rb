lines = File.readlines('input.txt').map { |line| line.strip }

times = lines[0].scan(/\d+/).map(&:to_i)

distances = lines[1].scan(/\d+/).map(&:to_i)

time_to_distance = Hash[times.zip(distances)]

def upper_limit(times, time, distance)
  middle = times.length / 2
  i = 0
  j = times.length - 1
  max_index = 0
  while i <= j
    time_left = time - middle
    speed = middle
    max_distance = time_left * speed
    if max_distance > distance
      max_index = middle if middle > max_index
      i = middle + 1
      middle = (i + j) / 2
    else
      j = middle - 1
      middle = (i + j) / 2
    end
  end

  max_index
end

def bottom_limit(times, time, distance)
  middle = times.length / 2
  i = 0
  j = times.length - 1
  min_index = j
  while i <= j
    time_left = time - middle
    speed = middle
    min_distance = time_left * speed
    if min_distance > distance
      min_index = middle if middle < min_index
      j = middle - 1
      middle = (i + j) / 2
    else
      i = middle + 1
      middle = (i + j) / 2
    end
  end

  min_index
end

totals = time_to_distance.map do |time, distance|
  times = (0...time).to_a
  max = upper_limit(times, time, distance)
  min = bottom_limit(times, time, distance)
  (min..max).count
end

puts totals.inject :*