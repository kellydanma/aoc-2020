# Part 1
valid = 0
input = File.readlines("input/day02.txt", chomp: true)
input.each do |line|
  arr = line.split(' ')
  range = arr[0].split('-')
  min = range[0].to_i
  max = range[1].to_i
  char = arr[1].tr(':', '')
  valid += 1 if arr[2].count(char) >= min && arr[2].count(char) <= max
end
puts "#{valid} passwords are valid."

# Part 2
valid = 0
input.each do |line|
  arr = line.split(' ')
  range = arr[0].split('-')
  pos1 = range[0].to_i - 1
  pos2 = range[1].to_i - 1
  char = arr[1].tr(':', '')
  one = arr[2][pos1] == char || arr[2][pos2] == char
  both = arr[2][pos1] == char && arr[2][pos2] == char
  valid += 1 if one && !both
end
puts "#{valid} passwords are valid."