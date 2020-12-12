instructions = File.readlines('input/day12.txt', chomp: true).map { |line|
  action = line.match(/[NSEWLRF]/)
  value = line.match(/\d+/)
  [action.to_s, value.to_s.to_i]
}.to_a

# orient changes direction based on counterclockwise rotation of the current orientation.
def orient(degrees, cur)
  direction = (degrees / 90) % 4
  cur if direction == 0
  new_directions = [[1, 0], [0, 1], [-1, 0], [0, -1]]
  new_directions[(new_directions.find_index(cur) + direction) % 4]
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

puts "Part 1: The Manhattan distance is #{manhattan_dist(instructions, 0, 0)}"
