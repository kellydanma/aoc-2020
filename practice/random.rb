# A proc is an instance of the Proc class,
# and can be stored in a variable.
# Proc objects are closures and remember the context in which they were created.
# A closure stores a function together with an environment.
square = Proc.new { |x| x ** 2 }
puts [2, 4, 6].collect!(&square) # The ampersand (&) converts the proc to a block.

def proc_demo_method
  proc_demo = Proc.new { return "Only I print!" }
  proc_demo.call
  "But what about me?" # Never reached
end

puts proc_demo_method

# Lamba is similar to proc, but doesn't return immediately.
# Unlike proc, lamba returns to its calling method.
def lambda_demo_method
  lambda_demo = lambda { return "Will I print?" }
  lambda_demo.call
  "Sorry - it's me that's printed."
end

puts lambda_demo_method

# Testing namespaces:
require "date"
puts Date.today
