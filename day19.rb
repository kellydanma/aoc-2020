data = File.read('input/day19.txt', chomp: true).split("\r\n\r\n")

rules = data[0].lines.map { |l|
  nr = l[/\d+:/].delete_suffix(':').to_i
  l = l.delete_prefix(l[/\d+:/]).to_s
  if l.match?(/[a-b]/)
    rule = l[/[a-b]/]
  elsif l.match?(/\|/)
    arr = l.split('|')
    rule1 = arr[0].split(' ').map { |n| n.to_i }
    rule2 = arr[1].split(' ').map { |n| n.to_i }
    rule = [rule1, rule2]
  else
    rule = l.split(' ').map { |n| n.to_i }
  end
  [nr, rule]
}.to_h

messages = data[1].lines.map { |l| l.rstrip }.to_a



