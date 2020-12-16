data = File.read('input/day16.txt', chomp: true).split("your ticket:")
ticket_data = data[1].split("nearby tickets:")

fields = data[0].lines.reverse.drop(1).reverse.map { |line|
  field = line[/(\w+(?: \w+)?)/]
  v = line.scan(/(\d+)/).map { |n| n.first.to_i }
  [field, [v[0]..v[1], v[2]..v[3]]] }.to_h
my_ticket = ticket_data[0].scan(/(\d+)/).map { |n| n.first.to_i }.to_a
nearby_tickets = ticket_data[1].lines.drop(1).map { |line|
  v = line.scan(/(\d+)/).map { |n| n.first.to_i }; v }.to_a

def valid_field?(ranges, field)
  ranges.each { |range| return true if range.cover?(field) }; false
end

def valid_ticket?(ranges, ticket)
  ticket.each { |field| return nil if !valid_field?(ranges, field) }; ticket
end

# Part 1
ranges = fields.values.flatten
error_rate = nearby_tickets.flatten.map { |field| valid_field?(ranges, field) ? 0 : field }.sum
puts "Part 1: #{error_rate}"

# Part 2
remaining = nearby_tickets.map { |t| valid_ticket?(ranges, t) }.reject { |t| t == nil } << my_ticket
