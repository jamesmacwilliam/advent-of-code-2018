lines = File.read('input.txt').split
two = 0
three = 0
final_match = nil

lines.each do |line|
  counts = line.chars.group_by {|c| c }.values.map(&:size)
  two += 1 if counts.include? 2
  three += 1 if counts.include? 3
  lines.each do |line2|
    break if final_match
    matched = line.chars.select.with_index {|c, i| c == line2[i] }
    final_match = matched.join if matched.size == line.size - 1
  end
end

puts two * three
puts final_match
