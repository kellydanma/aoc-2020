nums = File.readlines('input/day09.txt', chomp: true).map { |line| line.to_i }.to_a
rem = nums.drop(25)

def valid?(preamble, num)
  preamble.each { |p| return true if preamble.include?(num - p) }
  return false
end

# Part 1
invalid = 0
rem.each.with_index do |r, i|
  preamble = nums[i, 25]
  if !valid?(preamble, r)
    invalid = r
    puts "Part 1: #{invalid} is invalid."
    break
  end
end

# Part 2
def contiguous_sum(arr, target)
  contiguous = []
  sum = 0
  l = 0
  r = 0

  arr.each do |n|
    sum += n
    contiguous.push([sum, n])
  end

  while r < contiguous.length
    new_sum = contiguous[r][0] - contiguous[l][0]
    break if new_sum == target
    r += 1 if new_sum < target
    l += 1 if new_sum > target
  end

  contiguous = arr[l+1..r]
  contiguous.max + contiguous.min
end

puts "Part 2: #{contiguous_sum(nums, invalid)}."