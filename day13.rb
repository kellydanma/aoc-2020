input = File.readlines('input/day13.txt', chomp: true)
my_departure = input.first.to_s.to_i
bus_times = input.last.to_s.split(',').reject { |b| b == "x" }.map { |b| b.to_i }

def earliest(departure, schedule)
  id = -1
  wait_time = 1 << 64
  schedule.each do |s|
    return 0 if departure % s
    diff = (departure / s) * s + s - departure
    if diff < wait_time
      id = s
      wait_time = diff
    end
  end
  id * wait_time
end

puts "Part 1: #{earliest(my_departure, bus_times)}"