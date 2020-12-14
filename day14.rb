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

def mask_address(m, a)
  mm = m.split('').reverse
  aa = a.to_s.split('').reverse
  mm.zip(aa)
      .map { |m, a| next m if m == "X"; m == "1" ? 1 : a }
      .map { |v| v == nil ? "0" : v }
      .reverse
end

def floating_bits(addr)
  indices = addr.each.with_index.map { |v, i| i if v == "X" }.reject { |v| v == nil }
  combinations = indices.map { |i| [[i, "0"], [i, "1"]] }
  combinations = combinations.shift.product(*combinations)
  combinations.map { |c| a = addr.dup; c.each { |i, v| a[i] = v }; a }
      .map { |c| c.join.to_i(2) }
end

mem1 = {}
mem2 = {}
cur_mask = ""
File.readlines('input/day14.txt', chomp: true).each do |line|
  instruction, value = line.split(" = ")
  next cur_mask = value if instruction.include?("mask")

  # Part 1
  address = instruction[/\d+/].to_i
  val1 = value.to_i.to_s(2)
  mem1[address] = mask(cur_mask, val1)

  # Part 2
  val2 = value.to_i
  masked_address = mask_address(cur_mask, address.to_s(2))
  floating_bits(masked_address).each { |addr| mem2[addr] = val2 }
end
puts "Part 1: #{mem1.values.inject(:+)}"
puts "Part 2: #{mem2.values.inject(:+)}"
