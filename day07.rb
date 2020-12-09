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

# Part 2
def bags.nr_bags_in(outer)
  total = 0
  inner = self[outer]
  inner.each { |i| total += i[0] + i[0] * nr_bags_in(i[1]) }
  return total
end

puts "Part 2: #{bags.nr_bags_in("shiny gold bag") } bags."