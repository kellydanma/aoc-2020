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

def group(str)
  # See https://stackoverflow.com/questions/3705842/what-does-do-in-regex
  "(?:" + str + ")" # ?: means to group, but don't remember the grouped part.
end

def regex_helper(rules, key, cache, max_length)
  next_rule = rules[key]
  max_length -= 1
  return "" if max_length == 0
  return key unless next_rule # returns a key = a or b
  matches = next_rule.map { |g| g.map { |sub| build_regex(rules, sub, cache, max_length) }.join("") }.join("|")
  matches.include?("|") ? group(matches) : matches
end

def build_regex(rules, key, cache, max_length)
  cache[key] ||= regex_helper(rules, key, cache, max_length)
  # cache stores a map of regex for a specific rule:
  # eg. Given rules like,
  # 0: 4 1 5
  # 1: 2 3 | 3 2
  # 2: 4 4 | 5 5
  # 3: 4 5 | 5 4
  # 4: "a"
  # 5: "b"
  # cache = {"a"=>"a", 4=>"a", "b"=>"b", 5=>"b", 2=>"(?:aa|bb)", 3=>"(?:ab|ba)", 1=>"(?:(?:a
  # a|bb)(?:ab|ba)|(?:ab|ba)(?:aa|bb))"}
end

def valid_messages(rules, first_rule, messages, max_length)
  rule_regex = Regexp.new("^#{build_regex(rules, first_rule, {}, max_length)}$")
  messages.map { |n| rule_regex.match?(n) ? 1 : 0 }.sum
end

max_length = @messages.map { |m| m.length }.max
puts "Part 1: #{valid_messages(@rules, 0, @messages, max_length)} messages."

@rules[8] = [[42], [42, 8]]
@rules[11] = [[42, 31], [42, 11, 31]]
puts "Part 2: #{valid_messages(@rules, 0, @messages, max_length)} messages."