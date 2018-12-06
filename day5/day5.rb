input = 'dabAcCaCBAcCcaDA'
input = File.read('input.txt')

reg = []
('a'..'z').to_a.each { |c| reg << "(#{c}#{c.capitalize})|(#{c.capitalize}#{c})" }
reg = /#{reg.join('|')}/

def combust(str, reg)
  temp = str.gsub(reg, '')
  return combust(temp, reg) if temp.size < str.size
  return temp
end

puts combust(input, reg).size

('a'..'z').to_a.each do |c|
  puts "#{c}: #{combust(input.gsub(/#{c}/i, ''), reg).size}"
end
