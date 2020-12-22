@tiles = File.read('input/day20.txt', chomp: true).split("\r\n\r\n").map { |tile|
  image = tile.lines.map { |t| t.rstrip }
  nr = image.first[/\d+/].to_i
  image = image.drop(1).map { |row| row.split("") }
  [[image.first, image.transpose.first, image.last, image.transpose.last], nr] # up, left, down, right
}.to_h

# flip all of the tiles
existing_tiles = @tiles.keys
existing_tiles.each do |t|
  up, left, down, right = t
  @tiles[[up.reverse, right, down.reverse, left]] = @tiles[t]
end

# rotate all of the tiles
existing_tiles = @tiles.keys
existing_tiles.each do |t|
  up, left, down, right = t
  @tiles[[right, up.reverse, left, down.reverse]] = @tiles[t]
  @tiles[[down.reverse, right.reverse, up.reverse, left.reverse]] = @tiles[t]
  @tiles[[left.reverse, down, right.reverse, up.reverse]] = @tiles[t]
end
