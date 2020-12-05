input = File.readlines("input/day05.txt", chomp: true)

# A really bad binary search.
def b_search(arr, iter, lo, hi, char, pos)
  iter.times do
    mid = (lo + hi) / 2
    if arr[pos] == char
      hi = mid
    else
      lo = mid + 1
    end
    pos += 1
  end
  return lo # I could also return hi, it's the same.
end

highest_id = -1
seats = []

# Part 1
input.each do |line|
  row = b_search(line, 7, 0, 127, 'F', 0)
  col = b_search(line, 3, 0, 7, 'L', 7)
  id = row * 8 + col
  highest_id = id if id > highest_id
  seats.append(id)
end
puts "Part 1: The highest seat ID is #{highest_id}."

# Part 2
seats.sort!
for i in 0..seats.length - 2 do
  if seats[i + 1] - seats[i] == 2
    puts "Part 2: Your seat is #{seats[i] + 1}."
  end
end