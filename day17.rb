# process data
cubes_3d = Hash.new('.')
cubes_4d = Hash.new('.')
File.readlines('input/day17.txt', chomp: true).each_with_index.map { |row, x|
  row.split('').each_with_index.map { |col, y|
    cubes_3d[[x, y, 0]] = col
    cubes_4d[[x, y, 0, 0]] = col } }

# calculates the number of active cubes in neighbours (3d or 4d)
def nr_active_cubes(grid, dim, position)
  permutations = [[-1, 0, 1]] * dim
  neighbours = permutations.shift.product(*permutations)
  neighbours.delete([0] * dim)

  return neighbours.map do |dx, dy, dz|
    x, y, z = position
    x += dx; y += dy; z += dz
    grid[[x, y, z]] == "#" ? 1 : 0
  end.sum if dim == 3 # for 3d

  neighbours.map do |dx, dy, dz, dw|
    x, y, z, w = position
    x += dx; y += dy; z += dz; w += dw
    grid[[x, y, z, w]] == "#" ? 1 : 0
  end.sum # for 4d
end

# returns the new state of a cube
def change_state(active, cur_state)
  case cur_state
  when "." then
    return "#" if active == 3
  when "#" then
    return "." if active < 2 || active > 3
  end
  cur_state
end

def count(grid, dim, cycles)
  (1..cycles).each do |i|
    i *= -1
    copy = grid.clone
    bounds = grid.keys.transpose

    (i..bounds[0].max + 1).each do |x|
      (i..bounds[1].max + 1).each do |y|
        (i..bounds[2].max + 1).each do |z|
          if dim == 3
            active = nr_active_cubes(grid, dim, [x, y, z])
            next copy[[x, y, z]] = change_state(active, grid[[x, y, z]])
          end
          (i..bounds[3].max + 1).each do |w|
            active = nr_active_cubes(grid, dim, [x, y, z, w])
            copy[[x, y, z, w]] = change_state(active, grid[[x, y, z, w]])
          end
        end
      end
    end
    grid = copy
  end

  grid.values.count { |c| c == '#' }
end

puts "Part 1: #{count(cubes_3d, 3, 6)}"
puts "Part 2: #{count(cubes_4d, 4, 6)}"
