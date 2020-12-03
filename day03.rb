input = File.readlines("input/day03.txt", chomp: true)

len = input[0].length
slope0 = 0 # right 1, down 1
slope1 = 0 # right 3, down 1
slope2 = 0 # right 5, down 1
slope3 = 0 # right 7, down 1
slope4 = 0 # right 1, down 2
down = 0
nr_trees = [0, 0, 0, 0, 0] # nr of trees at each slope

input.each do |line|
  # Part 1
  nr_trees[1] += 1 if line[slope1 % len] == '#'
  slope1 += 3

  # Part 2
  nr_trees[0] += 1 if line[slope0 % len] == '#'
  slope0 += 1
  nr_trees[2] += 1 if line[slope2 % len] == '#'
  slope2 += 5
  nr_trees[3] += 1 if line[slope3 % len] == '#'
  slope3 += 7
  nr_trees[4] += 1 if line[slope4 % len] == '#' && down % 2 == 0
  slope4 += 1 if down % 2 == 0
  down += 1
end

puts "Part 1: # of trees = #{nr_trees[1]}"
puts "Part 2: product of trees = #{nr_trees.inject(:*)}"