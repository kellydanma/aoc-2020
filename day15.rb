def store(mem, key, turn)
  _, b = mem[key]
  !mem.has_key?(key) ? mem[key] = [nil, turn] : mem[key] = [b, turn]
end

def play(nums, last_turn)
  mem = {}
  nums.each.with_index { |n, i| mem[n] = [nil, i] }
  (nums.length...last_turn).each do |i|
    a, b = mem[nums[i - 1]]
    cur = a == nil ? 0 : b - a
    nums << cur
    store(mem, cur, i)
  end
  nums.last
end

puts "Part 1: #{play([1, 20, 11, 6, 12, 0], 2020)}"
puts "Part 2: #{play([1, 20, 11, 6, 12, 0], 30000000)}"