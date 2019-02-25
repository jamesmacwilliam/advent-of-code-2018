RubyVM::InstructionSequence.compile_option = {
  tailcall_optimization: true,
  trace_instruction: false
}

require 'set'
require 'pry'
require './sort.rb'

input = """
Step C must be finished before step A can begin.
Step C must be finished before step F can begin.
Step A must be finished before step B can begin.
Step A must be finished before step D can begin.
Step B must be finished before step E can begin.
Step D must be finished before step E can begin.
Step F must be finished before step E can begin.
""".split("\n").reject {|str| str == "" }
input = File.read('input.txt').split("\n").sort.reverse

INDEX_OF_REQ = 5
INDEX_OF_RULE = 36

letters = Hash.new { |h, k| h[k] = Set.new }

sorted = ('A'..'Z').to_a

input.each do |str|
  req = str[INDEX_OF_REQ]
  rule = str[INDEX_OF_RULE]

  req_pos = sorted.index(req)
  rule_pos = sorted.index(rule)

  sorted.insert(req_pos, sorted.delete(rule)) if rule_pos < req_pos

  #letters[last] << first
end

# initialize all filler letters
#('A'..letters.keys.max).each { |letter| letters[letter] }

#puts(sort(letters))
puts sorted.join
