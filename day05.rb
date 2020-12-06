input = File.readlines("input/day05.txt", chomp: true)

highest_id = -1
seats = []

# Part 1
# Using binary numbers
input.each do |line|
  id = 0
  for i in 0..9 do
    id += 1 << (9 - i) if line[i] == 'B' || line[i] == 'R'
  end
  seats.append(id)
  highest_id = id if id > highest_id
end
puts "Part 1: The highest seat ID is #{highest_id}."

# Part 2
seats.sort!
for i in 0..seats.length - 2 do
  puts "Part 2: Your seat is #{seats[i] + 1}." if seats[i + 1] - seats[i] == 2
end

# Part 1 (old implementation)
# Using a binary search
input.each do |line|
  i = 0
  lo = 0
  hi = 1023
  10.times do
    mid = (lo + hi) / 2
    if line[i] == 'F' || line[i] == 'L'
      hi = mid
    else
      lo = mid + 1
    end
    i += 1
  end
  seats.append(lo)
  highest_id = lo if lo > highest_id
end