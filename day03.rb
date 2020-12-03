input = File.readlines("input/day03.txt", chomp: true)

# Part 1
nr_trees = 0
right = 0
len = input[0].length
input.each do |line|
  nr_trees += 1 if line[right % len] == '#'
  right += 3
end
puts nr_trees