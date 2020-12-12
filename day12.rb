instructions = File.readlines('input/day12.txt', chomp: true).map { |line|
  action = line.match(/[NSEWLRF]/)
  value = line.match(/\d+/)
  [action.to_s, value.to_s.to_i]
}.to_a

# orient changes direction based on counterclockwise rotation of the current orientation.
def orient(degrees, cur)
  direction = (degrees / 90) % 4
  cur if direction == 0
  directions = [[1, 0], [0, 1], [-1, 0], [0, -1]]
  directions[(directions.find_index(cur) + direction) % 4]
end

def rotate(degrees, wp)
  directions = [[1, 0, 0, 1], [0, -1, 1, 0], [-1, 0, 0, -1], [0, 1, -1, 0]]
  dir = directions[(degrees / 90) % 4]
  [dir[0] * wp[0] + dir[1] * wp[1], dir[2] * wp[0] + dir[3] * wp[1]]
end

def manhattan_dist(instructions, x, y)
  orientation = [1, 0]
  instructions.each do |action, value|
    case action
    when "N"
      y += value
    when "S"
      y -= value
    when "E"
      x += value
    when "W"
      x -= value
    when "L"
      orientation = orient(value, orientation)
    when "R"
      orientation = orient(360 - value, orientation)
    when "F"
      dx, dy = orientation
      x += value * dx
      y += value * dy
    end
  end
  x.abs + y.abs
end

def manhattan_dist2(instructions, x, y)
  waypoint = [10, 1]
  instructions.each do |action, value|
    case action
    when "N"
      waypoint[1] += value
    when "S"
      waypoint[1] -= value
    when "E"
      waypoint[0] += value
    when "W"
      waypoint[0] -= value
    when "L"
      waypoint = rotate(value, waypoint)
    when "R"
      waypoint = rotate(360 - value, waypoint)
    when "F"
      dx, dy = waypoint
      x += value * dx
      y += value * dy
    end
  end
  x.abs + y.abs
end

puts "Part 1: The Manhattan distance is #{manhattan_dist(instructions, 0, 0)}"
puts "Part 2: The Manhattan distance is #{manhattan_dist2(instructions, 0, 0)}"