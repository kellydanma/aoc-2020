# Part 1
program = File.readlines('input/day08.txt', chomp: true).map { |line|
  instruction, val = line.split(' ')
  [instruction.to_s, val.to_i, true]
}.to_a

accumulator = 0
pos = 0

while program[pos][2] do
  program[pos][2] = false
  case program[pos][0]
  when "nop"
    pos += 1
  when "acc"
    accumulator += program[pos][1]
    pos += 1
  when "jmp"
    pos += program[pos][1]
  end
end

puts "Part 1: accumulator = #{accumulator}"
