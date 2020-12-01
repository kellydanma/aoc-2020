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
# Naive algorithm
for i in 0...(expenses.length - 2)
  for j in (i + 1)...(expenses.length - 1)
    for k in (j + 1)...(expenses.length)
      sum = expenses[i] + expenses[j] + expenses[k]
      puts "The 3 numbers, multiplied, equals #{expenses[i] * expenses[j] * expenses[k]}." if sum == 2020
    end
  end
end

# Part 2
# Improved algorithm
expenses.sort!
for i in 0...(expenses.length - 2)
  left = i + 1
  right = expenses.length - 1
  while left < right
    sum = expenses[i] + expenses[left] + expenses[right]
    if sum == 2020
      puts "The 3 numbers, multiplied, equals #{expenses[i] * expenses[left] * expenses[right]}."
      break
    elsif sum < 2020
      left += 1
    else
      right -= 1
    end
  end
end
