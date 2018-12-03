changes= File.read('input.txt').split.map(&:to_i)
frequency = 0
first_frequency = 0
existing = [0]
first_twice = nil

i = 0
loop do
  changes.each do |change|
    frequency += change
    first_twice ||= frequency if existing.include? frequency
    existing << frequency
    first_frequency = frequency if i == 0
    break if first_twice && i > 0
  end
  break if first_twice && i > 0
  i += 1
end

puts first_frequency
puts first_twice
