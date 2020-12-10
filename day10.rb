jolts = File.readlines('input/day10.txt', chomp: true).map { |line| line.to_i }.to_a
sorted = jolts.sort.unshift(0)
sorted = sorted + [sorted[sorted.length - 1] + 3]

# Part 1
def diffs(adapters)
  diff = Hash.new(0)
  adapters.each_cons(2) { |a, b| diff[b - a] += 1 }
  diff[1] * diff[3]
end

puts "Part 1: 1-jolt diffs * 3-jolt diffs = #{diffs(sorted)}."

# Part 2
def combos(adapters, dp, n)
  return 0 if !adapters.include? n
  return 1 if n == 0
  dp[n] ||= (1..3).sum { |x| combos(adapters, dp, n - x) }
end

puts "Part 2: #{combos(sorted, [], sorted.last)} possible combinations."