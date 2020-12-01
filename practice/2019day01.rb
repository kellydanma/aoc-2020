modules = File.readlines("2019day01.txt", chomp: true).map do |line|
  line.to_i
end
fuel = modules.collect { |m| m / 3 - 2 }
puts fuel.inject(:+)