input = File.readlines("input/day04.txt", chomp: true)
input.append("") # my buffer

# all of the required passport fields
required = {byr: 0, iyr: 1, eyr: 2, hgt: 3, hcl: 4, ecl: 5, pid: 6}

def is_valid(key, value)
  eye_colour = {amb: 1, blu: 1, brn: 1, gry: 1, grn: 1, hzl: 1, oth: 1} # valid eye colours
  case key
  when "byr"
    value.to_i >= 1920 && value.to_i <= 2002
  when "iyr"
    value.to_i >= 2010 && value.to_i <= 2020
  when "eyr"
    value.to_i >= 2020 && value.to_i <= 2030
  when "hgt"
    false if value.length < 4 || value.length > 5
    case value[-2..-1]
    when "cm"
      false if value.length != 5
      height = value[0..2].to_i
      height >= 150 && height <= 193
    when "in"
      false if value.length != 4
      height = value[0..1].to_i
      height >= 59 && height <= 76
    else
      false
    end
  when "hcl"
    value.match?(/\A#[0-9a-f]{6}\z/)
  when "ecl"
    eye_colour.has_key? value.to_sym
  when "pid"
    value.match?(/\A[0-9]{9}\z/)
  else
    false
  end
end

valid1 = 0 # nr of valid passports
valid2 = 0
fields1 = [0, 0, 0, 0, 0, 0, 0] # fields[i] = 1 if the field is present, 0 if not
fields2 = [0, 0, 0, 0, 0, 0, 0]

input.each do |line|
  pairs = line.split(' ')
  pairs.each do |pair|
    kv = pair.split(':')
    if required.has_key? kv[0].to_sym
      fields1[required[kv[0].to_sym]] = 1
      fields2[required[kv[0].to_sym]] = 1 if is_valid(kv[0], kv[1])
    end
  end
  if line.length == 0
    valid1 += 1 if fields1.inject(:*) == 1
    valid2 += 1 if fields2.inject(:*) == 1
    fields1 = [0, 0, 0, 0, 0, 0, 0]
    fields2 = [0, 0, 0, 0, 0, 0, 0]
  end
end

puts "Part 1: There are #{valid1} valid passports."
puts "Part 2: There are #{valid2} valid passports."