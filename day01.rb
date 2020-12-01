expenses = File.readlines("input/day01.txt", chomp: true).map do |line|
  line.to_i
end
nums = Hash.new
expenses.each do |e|
  puts e * (2020-e) if nums.has_key?(2020 - e)
  nums[e] = 1
end
