input = File.readlines('input/day14.txt', chomp: true)

def mask(m, v)
  mm = m.split('').reverse
  vv = v.to_s.split('').reverse
  mm.zip(vv)
      .map { |m, v| m == "X" ? v : m }
      .map { |v| v == nil ? "0" : v }
      .reverse
      .join
      .to_i(2)
end

# Part 1
memory = {}
cur_mask = ""
input.each do |line|
  instruction, value = line.split(" = ")
  next cur_mask = value if instruction.include?("mask")
  address = instruction[/\d+/].to_i
  value = value.to_i.to_s(2)
  memory[address] = mask(cur_mask, value)
end
puts "Part 1: #{memory.values.inject(:+)}"


