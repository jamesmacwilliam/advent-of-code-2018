require 'set'

lines = File.read('input.txt').split("\n")
felt = []
overlap = 0
no_overlap = Set.new


lines.each do |line|
  match = line.match(/[#](\d+) @ (\d+)[,](\d+)[:] (\d+)[x](\d+)/)
  puts line unless match
  id = match[1].to_i
  x = match[2].to_i
  y = match[3].to_i
  width = match[4].to_i
  height = match[5].to_i
  no_overlap.add id
  (y + 1..y + height).to_a.each do |y_coord|
    (x + 1..x + width).to_a.each do |x_coord|
      felt[y_coord] ||= []
      felt[y_coord][x_coord] ||= []
      felt[y_coord][x_coord] << id
    end
  end
end

felt.map do |y_ax|
  next unless y_ax
  y_ax.map do |x_ax|
    next unless x_ax
    if x_ax.size > 1
      x_ax.each { |val| no_overlap.delete(val) }
      overlap += 1
    end
  end
end

puts overlap
puts no_overlap.to_a
