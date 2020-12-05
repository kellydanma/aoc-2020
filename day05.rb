input = File.readlines("input/day05.txt", chomp: true)

highest_id = -1
seats = []

input.each do |line|
  pos = 0
  lo = 0
  hi = 127
  7.times do
    mid = (lo + hi) / 2
    if line[pos] == 'F'
      hi = mid
    else
      lo = mid + 1
    end
    pos += 1
  end
  row = lo
  lo = 0
  hi = 7
  3.times do
    mid = (lo + hi) / 2
    if line[pos] == 'L'
      hi = mid
    else
      lo = mid + 1
    end
    pos += 1
  end
  id = row * 8 + lo
  seats.append(id)
  highest_id = id if id > highest_id
end

puts "Part 1: the highest seat ID is #{highest_id}."

seats.sort!
for i in 0..seats.length-2 do
  if seats[i+1]-seats[i] ==2
    puts "Part 2: your seat is #{seats[i]+1}."
  end
end