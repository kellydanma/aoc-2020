initial_state = File.readlines('input/day17.txt', chomp: true).map { |l| l.to_s.split('') }.to_a

def change_state(grid, position)
  permutations = [[-1, 0, 1], [-1, 0, 1], [-1, 0, 1]]
  neighbours = permutations.shift.product(*permutations)
  neighbours.delete([0, 0, 0])

  active = 0
  neighbours.each do |dx, dy, dz|
    x, y, z = position
    x += dx
    y += dy
    z += dz
    next if x < 0 || x > grid.length - 1
    next if y < 0 || y > grid[0].length - 1
    next if z < 0 || z > grid[0][0].length - 1
    active += 1 if grid[x][y][z] == "#"
  end

  x, y, z = position
  cur_state = grid[x][y][z]
  case cur_state
  when "." then
    return "#" if active == 3
  when "#" then
    return "." if active < 2 || active > 3
  end
  cur_state
end
