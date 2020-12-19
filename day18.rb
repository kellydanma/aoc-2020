# Data processing, override * with -
equations = File.readlines('input/day18.txt', chomp: true).map { |l| l.gsub("*", "-") }

# Mess with the integer class so that subtraction represents multiplication & exponent represents addition.
class Integer
  def -(num)
    self * num
  end

  def **(num)
    self + num
  end
end

puts "Part 1: #{equations.map { |e| eval(e) }.sum}"
puts "Part 2: #{equations.map { |e| eval(e.gsub("+", "**")) }.sum}"