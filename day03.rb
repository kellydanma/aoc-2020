input = File.readlines("input/day03.txt", chomp: true)

len = input[0].length
slope = [0, 0, 0, 0, 0]
down = 0
nr_trees = [0, 0, 0, 0, 0] # nr of trees at each slope

input.each do |line|
  # Part 1
  nr_trees[0] += 1 if line[slope[0] % len] == '#'
  slope[0] += 3

  # Part 2
  nr_trees[1] += 1 if line[slope[1] % len] == '#'
  slope[1] += 1
  nr_trees[2] += 1 if line[slope[2] % len] == '#'
  slope[2] += 5
  nr_trees[3] += 1 if line[slope[3] % len] == '#'
  slope[3] += 7
  if down % 2 == 0
    nr_trees[4] += 1 if line[slope[4] % len] == '#'
    slope[4] += 1
  end
  down += 1
end

puts "Part 1: # of trees = #{nr_trees[0]}"
puts "Part 2: product of trees = #{nr_trees.inject(:*)}"