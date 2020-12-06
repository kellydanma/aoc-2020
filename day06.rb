input = File.readlines("input/day06.txt", chomp: true)
input.append("")

# Part 1
yes = 0
letters = Hash.new(0)
input.each do |line|
  if line.length == 0
    yes += letters.size()
    letters = Hash.new(0)
  else
    chars = line.split('')
    chars.each { |c| letters[c] += 1 }
  end
end

puts "Part 1: #{yes} answers."
