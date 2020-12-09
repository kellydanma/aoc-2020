# Part 1
bags = File.readlines('input/day07.txt', chomp: true).map { |line|
  outer = line[/^(\w+ \w+ \w+)/].delete_suffix('s')
  inner = line.gsub(/bags/, 'bag').scan(/(\d+) (\w+ \w+ \w+)/)
              .map { |nr, color| [nr.to_i, color] }
  [outer, inner]
}.to_h

def bags.contains?(outer)
  inner = self[outer].map(&:last)
  inner.any? { |i| i.eql? "shiny gold bag" } || inner.any? { |i| contains?(i) }
end

puts "Part 1: #{bags.keys.count { |bag| bags.contains?(bag) }} bags."