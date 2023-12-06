lines = File.readlines('input.txt').map { |line| line.strip }

times = lines[0].scan(/\d+/).map(&:to_i)

distances = lines[1].scan(/\d+/).map(&:to_i)

time_to_distance = Hash[times.zip(distances)]

max_distances = time_to_distance.map do |time, distance|
  #puts "Time: #{time}. Record distance: #{distance} mm"
  max_distances = (0..time).select do |t|
    time_left = time - t
    speed = t
    max_distance = time_left * speed
    max_distance > distance
  end
  max_distances.length
end

p max_distances.inject :*