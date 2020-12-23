@tiles = File.read('input/day20.txt', chomp: true).split("\r\n\r\n").map { |tile|
  img = tile.lines.map { |t| t.rstrip }
  nr = img.first[/\d+/].to_i
  img = img.drop(1)
  img_trans = img.map { |row| row.split("") }.transpose.map { |row| row.join("") }
  [[img.first, img_trans.first, img.last, img_trans.last], nr] # up, left, down, right
}.to_h

ids = @tiles.values

# flip all of the tiles
existing_tiles = @tiles.keys
existing_tiles.each do |t|
  up, left, down, right = t
  @tiles[[up.reverse, right, down.reverse, left]] = @tiles[t]
  @tiles[[down, left.reverse, up, right.reverse]] = @tiles[t]
end

# rotate all of the tiles
existing_tiles = @tiles.keys
existing_tiles.each do |t|
  up, left, down, right = t
  @tiles[[right, up.reverse, left, down.reverse]] = @tiles[t]
  @tiles[[down.reverse, right.reverse, up.reverse, left.reverse]] = @tiles[t]
  @tiles[[left.reverse, down, right.reverse, up.reverse]] = @tiles[t]
end

# Part 1
@borders = @tiles.keys.transpose
unique = Hash.new(0)
@tiles.each { |bd, id| unique[id] += bd.map.with_index { |b, n| @borders[n].one?(b) ? 1 : 0 }.sum }
part1 = unique.select { |_, n| n == 12 }.map { |id, _| id }
puts "Part 1: #{part1.inject(:*)}"
