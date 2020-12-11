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

def visible(layout, pos, x_min, x_max, y_min, y_max)
  occupied = 0
  directions = [[1, 0], [-1, 0], [0, 1], [0, -1], [1, 1], [1, -1], [-1, 1], [-1, -1]]
  directions.each do |dx, dy|
    x = pos[0] + dx
    y = pos[1] + dy
    while x >= x_min && x <= x_max && y >= y_min && y <= y_max do
      if layout[x][y] == "."
        x += dx
        y += dy
        next
      end
      occupied += layout[x][y] == "#" ? 1 : 0
      break
    end
  end
  occupied
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

# Part 2
l = layout.map(&:dup)
w = layout.first.length - 1
h = layout.length - 1
loop do
  copy = l.map(&:dup)
  (0...layout.length).each do |i|
    (0...layout.first.length).each do |j|
      case l[i][j]
      when "L" then
        copy[i][j] = "#" if visible(l, [i, j], 0, h, 0, w) == 0
      when "#" then
        copy[i][j] = "L" if visible(l, [i, j], 0, h, 0, w) >= 5
      end
    end
  end
  break if l == copy
  l = copy
end

puts "Part 2: #{l.join.count("#")} seats are occupied."
