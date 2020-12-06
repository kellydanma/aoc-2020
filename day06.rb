input = File.readlines("input/day06.txt", chomp: true)
input.append("")

# Part 1
yes = 0
letters = []
input.each do |line|
  if line.length == 0
    yes += letters.uniq.length
    letters = []
  else
    chars = line.split('')
    chars.each { |c| letters.append(c) }
  end
end
puts "Part 1: #{yes} answers."

# Part 2
yes = 0
letters = Hash.new(1)
nr_people = 0
input.each do |line|
  if line.length == 0
    letters.each do |l, c|
      yes += 1 if c == nr_people
    end
    letters = Hash.new(0)
    nr_people = 0
  else
    nr_people += 1
    chars = line.split('')
    chars.each { |c| letters[c] += 1 }
  end
end
puts "Part 2: #{yes} answers."
