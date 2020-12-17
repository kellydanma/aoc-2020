# Process data
cubes = Hash.new('.')
File.readlines('input/day17.txt', chomp: true).each_with_index.map { |row, x|
  row.split('').each_with_index.map { |col, y| cubes[[x, y, 0]] = col } }

def nr_active_cubes(grid, position)
  permutations = [[-1, 0, 1], [-1, 0, 1], [-1, 0, 1]]
  neighbours = permutations.shift.product(*permutations)
  neighbours.delete([0, 0, 0])
  neighbours.map do |dx, dy, dz|
    x, y, z = position
    x += dx; y += dy; z += dz
    grid[[x, y, z]] == "#" ? 1 : 0
  end.sum
end

def change_state(active, cur_state)
  case cur_state
  when "." then
    return "#" if active == 3
  when "#" then
    return "." if active < 2 || active > 3
  end
  cur_state
end

def count(grid, cycles)
  (1..cycles).each do |i|
    i *= -1
    copy = grid.clone
    bounds = grid.keys.transpose
    (i..bounds[0].max + 1).each { |x|
      (i..bounds[1].max + 1).each { |y|
        (i..bounds[2].max + 1).each { |z|
          active = nr_active_cubes(grid, [x, y, z])
          copy[[x, y, z]] = change_state(active, grid[[x, y, z]]) } } }
    grid = copy
  end
  grid.values.count { |c| c == '#' }
end

puts "Part 1: #{count(cubes, 6)}"
