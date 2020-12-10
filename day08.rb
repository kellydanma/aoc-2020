# Part 1
program = File.readlines('input/day08.txt', chomp: true).map { |line|
  instruction, val = line.split(' ')
  [instruction.to_s, val.to_i, false]
}.to_a

def loops?(program)
  acc = 0
  pos = 0
  while pos < program.length() do
    return true, acc if program[pos][2]
    program[pos][2] = true
    case program[pos][0]
    when "nop"
      pos += 1
    when "acc"
      acc += program[pos][1]
      pos += 1
    when "jmp"
      pos += program[pos][1]
    end
  end
  return false, acc
end

puts "Part 1: accumulator = #{loops?(program.map(&:clone))[1]}"

# Part 2
program.each.with_index do |p, i|
  new_program = program.map(&:clone)
  case new_program[i][0]
  when "nop" then
    new_program[i][0] = "jmp"
  when "jmp" then
    new_program[i][0] = "nop"
  else
    next
  end
  ans = loops?(new_program)
  puts "Part 2: accumulator = #{ans[1]}" if !ans[0]
end
