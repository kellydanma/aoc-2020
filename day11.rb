layout = File.readlines('input/day11.txt', chomp: true).map { |line|
  line.to_s.split('')
      .unshift(".")
      .append(".")
}.to_a

# Surround with dots lol
layout.unshift(["."] * layout[0].length)
    .append(["."] * layout[0].length)

def neighbours(layout, pos)
  adjacent = 0
  neighbour = [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [1, -1], [-1, 1], [-1, -1]]
  neighbour.each do |dx, dy|
    x, y = pos
    x += dx
    y += dy
    adjacent += 1 if layout[x][y] == "#"
  end
  adjacent
end

# Part 1
l = layout.map(&:dup)
loop do
  copy = l.map(&:dup)
  (0...layout.length).each do |i|
    (0...layout.first.length).each do |j|
      case l[i][j]
      when "L" then
        copy[i][j] = "#" if neighbours(l, [i, j]) == 0
      when "#" then
        copy[i][j] = "L" if neighbours(l, [i, j]) >= 4
      end
    end
  end
  break if l == copy
  l = copy
end

puts "Part 1: #{l.join.count("#")} seats are occupied."

