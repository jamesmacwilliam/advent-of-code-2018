require 'pry'
require 'set'
#input = File.read('test_input.txt').split("\n").map {|s| s.split(', ').map(&:to_i) }
input = File.read('input.txt').split("\n").map {|s| s.split(', ').map(&:to_i) }

maxx = input.max { |a, b| a.first <=> b.first }.first
maxy = input.max { |a, b| a.last <=> b.last }.last
#minx = input.min { |a, b| a.first <=> b.first }.first
#miny = input.min { |a, b| a.last <=> b.last }.last

#internal = input.reject { |a| [minx, maxx].include?(a.first) || [miny, maxy].include?(a.last) }

coords_to_remove = Set.new

coords = {}
(0..maxx).each do |x|
  (0..maxy).each do |y|
    distances = input.map do |c|
      [((c.first - x).abs + (c.last - y).abs), c]
    end.inject({}) do |h, c|
      distance = c.first
      coord = c.last
      h[distance] ||= []
      h[distance] << coord
      h
    end
    closest = distances[distances.keys.min]
    coords[[x, y]] = closest.size > 1 ? nil : closest.first
    coords_to_remove.add(coords[[x,y]]) if maxx == x && coords[[x-1, y]] == coords[[x, y]]
    coords_to_remove.add(coords[[x,y]]) if maxy == y && coords[[x, y -1]] == coords[[x, y]]
  end
end

#### produce coords hash with closest coord
#  {
#    coord_tuple => closest_coord_tuple,
#    coord_tuple => nil (no closest coord)
#  }
###########################################

part1_coords = coords.delete_if { |_k, coord| coords_to_remove.include?(coord) }

# solve for part 1
p(part1_coords.values.uniq.inject({}) do |h, coord|
  h[coord] = part1_coords.count { |_k, v| v == coord }
  h
end)

#puts(part1_coords.values.uniq.inject({}) do |h, coord|
  #h[coord] = part1_coords.count { |_k, v| v == coord }
  #h
#end.max_by { |_, v| v }.last)

#puts(internal.inject({}) do |h, coord|
  #h[coord] = coords.count { |_k, v| v == coord }
  #h
#end.max_by { |_, v| v }.last)
