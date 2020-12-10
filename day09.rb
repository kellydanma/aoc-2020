nums = File.readlines('input/day09.txt', chomp: true).map { |line| line.to_i }.to_a
rem = nums.drop(25)

def valid?(preamble, num)
  preamble.each { |p| return true if preamble.include?(num - p) }
  return false
end

# Part 1
rem.each.with_index do |r, i|
  preamble = nums[i, 25]
  if !valid?(preamble, r)
    puts "Part 1: #{r} is invalid."
    break
  end
end