input = File.readlines("input/day04.txt", chomp: true)
input.append("") # my buffer

required = {
    byr: 0,
    iyr: 1,
    eyr: 2,
    hgt: 3,
    hcl: 4,
    ecl: 5,
    pid: 6,
}
valid = 0 # nr of valid passports
fields = [0, 0, 0, 0, 0, 0, 0] # fields[i] = 1 if the field is present, 0 if not

input.each do |line|
  # Part 1
  pairs = line.split(' ')
  pairs.each do |pair|
    kv = pair.split(':')
    fields[required[kv[0].to_sym]] = 1 if required.has_key? kv[0].to_sym
  end
  if line.length == 0
    valid += 1 if fields.inject(:*) == 1
    fields = [0, 0, 0, 0, 0, 0, 0]
  end
end

puts "Part 1: There are #{valid} valid passports."