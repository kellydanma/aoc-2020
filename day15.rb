def store(mem, key, turn)
  a, b = mem[key]
  return mem[key] = [nil, turn] if !mem.has_key?(key)
  return mem[key] = [b, turn]
end

# Part 1
mem = {}
nums = [1, 20, 11, 6, 12, 0]
nums.each.with_index { |n, i| mem[n] = [nil, i] }
(nums.length...2020).each do |i|
  a, b = mem[nums[i - 1]]
  cur = a == nil ? 0 : b - a
  nums.append(cur)
  store(mem, cur, i)
end

puts "Part 1: #{nums.last}"