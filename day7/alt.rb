#!/usr/bin/env ruby

input = File.read('input.txt')

rules = input.split("\n")

steps = Hash.new { |h, k| h[k] = Array.new }

rules.each do |rule|
  req, step = rule.scan(/\s(\w)\s/).map(&:first)

  steps[step] << req
end

todo = ("A"..(steps.keys.max)).to_a

done = []

while todo.any?
  todo.each do |step|
    next if steps[step].any?

    todo.delete(step)
    done << step

    steps.each do |_, reqs|
      reqs.delete(step)
    end

    break
  end
end

puts done.join
