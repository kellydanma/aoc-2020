input = File.readlines("input/day06.txt", chomp: true)
input.append("") # my buffer

some = 0 # Part 1
arr1 = [0] * 26

all = 0 # Part 2
arr2 = [1] * 26

input.each do |line|
  if line.length == 0
    some += arr1.inject(:+)
    all += arr2.inject(:+)
    arr1 = [0] * 26
    arr2 = [1] * 26
  else
    chars = line.split('')
    for i in 0..25 do
      arr1[i] |= 1 if chars.include?((i + 97).chr)
      arr2[i] &= 0 if !(chars.include?((i + 97).chr))
    end
  end
end

puts "Part 1: #{some} answers."
puts "Part 2: #{all} answers."
