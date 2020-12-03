valid1 = 0
valid2 = 0
input = File.readlines("input/day02.txt", chomp: true)
input.each do |line|
  arr = line.split(' ')
  range = arr[0].split('-')
  min = range[0].to_i
  max = range[1].to_i
  char = arr[1][0]

  # Part 1
  valid1 += 1 if arr[2].count(char) >= min && arr[2].count(char) <= max

  # Part 2
  one = arr[2][min - 1] == char || arr[2][max - 1] == char
  both = arr[2][min - 1] == char && arr[2][max - 1] == char
  valid2 += 1 if one && !both
end
puts "Part 1: #{valid1} passwords are valid."
puts "Part 2: #{valid2} passwords are valid."