input = File.readlines('input/day13.txt', chomp: true)
my_departure = input.first.to_s.to_i
bus_times = input.last.to_s.split(',').map { |b| b.to_i if b.match?(/\d+/) }

def earliest(departure, schedule)
  id = -1
  wait_time = 1 << 64
  schedule.each do |s|
    return 0 if departure % s == 0
    diff = (departure / s) * s + s - departure
    if diff < wait_time
      id = s
      wait_time = diff
    end
  end
  id * wait_time
end

def extended_gcd(a, b)
  last_remainder, remainder = a.abs, b.abs
  x, last_x, y, last_y = 0, 1, 1, 0
  while remainder != 0
    last_remainder, (quotient, remainder) = remainder, last_remainder.divmod(remainder)
    x, last_x = last_x - quotient * x, x
    y, last_y = last_y - quotient * y, y
  end
  return last_remainder, last_x * (a < 0 ? -1 : 1)
end

def invmod(e, et)
  g, x = extended_gcd(e, et)
  raise 'Multiplicative inverse modulo does not exist!' if g != 1
  x % et
end

def earliest2(schedule)
  # CRT implementation from https://rosettacode.org/wiki/Chinese_remainder_theorem#Ruby
  schedule = schedule.each.with_index.map { |b, i| [b, (i * -1) % b] if b != nil }.reject { |s| s == nil }
  mods, remainders = schedule.transpose
  max = mods.inject(:*) # product of all moduli
  series = remainders.zip(mods).map { |r, m| (r * max * invmod(max / m, m) / m) }
  series.inject(:+) % max
end

puts "Part 1: #{earliest(my_departure, bus_times.reject { |b| b == nil })}"
puts "Part 2: #{earliest2(bus_times)}"