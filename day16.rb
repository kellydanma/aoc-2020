data = File.read('input/day16.txt', chomp: true).split("your ticket:")
ticket_data = data[1].split("nearby tickets:")

# Data processing
fields = data[0].lines.reverse.drop(1).reverse.map { |line|
  field = line[/(\w+(?: \w+)?)/]
  v = line.scan(/(\d+)/).map { |n| n.first.to_i }
  [field, [v[0]..v[1], v[2]..v[3]]] }.to_h
my_ticket = ticket_data[0].scan(/(\d+)/).map { |n| n.first.to_i }.to_a
nearby_tickets = ticket_data[1].lines.drop(1).map { |line|
  v = line.scan(/(\d+)/).map { |n| n.first.to_i }; v }.to_a

def valid_field?(ranges, field)
  ranges.any? { |range| range.cover?(field) }
end

def valid_fields?(ranges, fields)
  fields.all? { |f| valid_field?(ranges, f) }
end

def valid_ticket?(ranges, ticket)
  ticket.each { |field| return nil if !valid_field?(ranges, field) }; ticket
end

# Part 1
ranges = fields.values.flatten
error_rate = nearby_tickets.flatten.map { |field| valid_field?(ranges, field) ? 0 : field }.sum
puts "Part 1: #{error_rate}"

# Part 2
remaining = nearby_tickets.reject { |t| valid_ticket?(ranges, t) == nil } << my_ticket
my_fields = (0...my_ticket.length).map { |i|
  rem = remaining.transpose[i]
  fields.map { |field, ranges| valid_fields?(ranges, rem) ? field : [] }
      .reject { |f| f.empty? } }
                .map.with_index
                .sort_by { |i, _| i.count }

(0...my_ticket.length).each do |i|
  (i + 1...my_ticket.length).each { |f| my_fields[f][0] -= [my_fields[i][0][0]] } if my_fields[i][0].one?
end

departures = my_fields.map { |field, pos|
  field.first.include?("departure") ? my_ticket[pos] : 1 }.inject(:*)

puts "Part 2: #{departures}"
