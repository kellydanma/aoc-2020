data = File.read('input/day19.txt', chomp: true).split("\r\n\r\n")
@messages = data.last.lines.map { |l| l.rstrip }.to_a
@rules = data.first.lines.map { |l|
  nr = l[/\d+:/].delete_suffix(':').to_i
  l = l.delete_prefix(l[/\d+:/]).to_s
  if l.match?(/[ab]/)
    rule = [[l[/[ab]/]]]
  elsif l.match?(/\|/)
    arr = l.split('|')
    rule1 = arr[0].split(' ').map { |n| n.to_i }
    rule2 = arr[1].split(' ').map { |n| n.to_i }
    rule = [rule1, rule2]
  else
    rule = [l.split(' ').map { |n| n.to_i }]
  end
  [nr, rule]
}.to_h

def parenthesize(str)
  "(" + str + ")"
end

def regex_helper(rules, key, cache)
  next_rule = rules[key]
  return key unless next_rule # returns a key = a or b
  groups = next_rule.map { |g| g.map { |sub| build_regex(rules, sub, cache) }.join("") }.join("|")
  groups.include?("|") ? parenthesize(groups) : groups
end

def build_regex(rules, key, cache)
  cache[key] ||= regex_helper(rules, key, cache)
  # cache stores a map of regex for a specific rule:
  # eg. Given rules like,
  # 0: 4 1 5
  # 1: 2 3 | 3 2
  # 2: 4 4 | 5 5
  # 3: 4 5 | 5 4
  # 4: "a"
  # 5: "b"
  # cache = {"a"=>"a", 4=>"a", "b"=>"b", 5=>"b", 2=>"(aa|bb)", 3=>"(ab|ba)", 1=>"((aa|bb)(ab|ba)|(ab|ba)(aa|bb))"}
end

def valid_messages(rules, first_rule, messages)
  rule_regex = Regexp.new("^#{build_regex(rules, first_rule, {})}$")
  messages.map { |n| rule_regex.match?(n) ? 1 : 0 }.sum
end

puts "Part 1: #{valid_messages(@rules, 0, @messages)} messages."

