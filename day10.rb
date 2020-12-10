jolts = File.readlines('input/day10.txt', chomp: true).map { |line| line.to_i }.to_a

# Part 1
sorted = jolts.sort.unshift(0)
one = 0
three = 1
(0...sorted.length - 1).each { |i|
  one += 1 if sorted[i + 1] - sorted[i] == 1
  three += 1 if sorted[i + 1] - sorted[i] == 3
}
puts "Part 1: 1-jolt diffs * 3-jolt diffs = #{one * three}."

# Part 2
def combos(adapters, dp, n)
  return 0 if !adapters.include? n
  return 1 if n == 0
  dp[n] ||= (1..3).sum { |x| combos(adapters, dp, n - x) }
end

sorted = sorted + [sorted[sorted.length - 1] + 3]
puts "Part 2: #{combos(sorted, [], sorted.last)} possible combinations."