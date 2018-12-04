require 'time'
require 'pry'

lines = File.read('input.txt').split("\n").map do |line|
  match = line.match(/.([-0-9: ]+). (.*)/)
  [Time.parse(match[1]), match[2]]
end.sort_by {|a| a.first }

id = nil
@guards = {}
@asleep = nil

def update_sleep_time(awake, id)
  @guards[id] ||= Array.new(60, 0)
  (@asleep...awake).each do |min|
    @guards[id][min] += 1
  end
  @asleep = nil
end

lines.each do |line|
  action = line.last
  time = line.first
  guard_match = action.match(/Guard [#](\d+)/)
  minutes = time.strftime('%M').to_i
  if guard_match
    update_sleep_time(minutes, id) if @asleep
    id = guard_match[1]
  end
  @asleep = minutes if action.include? 'asleep'
  next unless action.include? 'up'
  update_sleep_time(minutes, id)
end

strat1_sorted = @guards.sort_by { |_, m| m.reduce(:+) }

max_id = strat1_sorted.last.first.to_i
max_minutes = strat1_sorted.last.last

puts max_id * (max_minutes.index(max_minutes.max))

strat2_sorted = @guards.sort_by { |_, m| m.max }

max_id = strat2_sorted.last.first.to_i
max_minutes = strat2_sorted.last.last

puts max_id * (max_minutes.index(max_minutes.max))
