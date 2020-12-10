jolts = File.readlines('input/day10.txt', chomp: true).map { |line| line.to_i }.to_a

# Part 1
sorted_jolts = jolts.sort.unshift(0)
one = 0
three = 1
(0...sorted_jolts.length - 1).each { |i|
  one += 1 if sorted_jolts[i+1] - sorted_jolts[i] == 1
  three += 1 if sorted_jolts[i+1] - sorted_jolts[i] == 3
}

puts "Part 1: 1-jolt diffs * 3-jolt diffs = #{one * three}."