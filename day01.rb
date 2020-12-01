expenses = File.readlines("input/day01.txt", chomp: true).map do |line|
  line.to_i
end

# Part 1
nums = Hash.new
expenses.each do |e|
  puts "The 2 numbers, multiplied, equals #{e * (2020 - e)}." if nums.has_key?(2020 - e)
  nums[e] = 1
end

# Part 2
for i in 0..(expenses.length - 3)
  for j in (i + 1)..(expenses.length - 2)
    for k in (j + 1)..(expenses.length - 1)
      sum = expenses[i] + expenses[j] + expenses[k]
      puts expenses[i] * expenses[j] * expenses[k] if sum == 2020
    end
  end
end
