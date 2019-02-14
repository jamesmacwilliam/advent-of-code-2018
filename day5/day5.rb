input = 'dabAcCaCBAcCcaDA'
input = File.read('input.txt')

reg = []
('a'..'z').to_a.each { |c| reg << "(#{c}#{c.capitalize})|(#{c.capitalize}#{c})" }
reg = /#{reg.join('|')}/

def combust(str, reg, i = 0)
  temp = str.gsub(reg, '')
  i += 1
  return combust(temp, reg, i) if temp.size < str.size
  puts i
  return temp
end

puts combust(input, reg).size

#('a'..'z').to_a.each do |c|
  #puts "#{c}: #{combust(input.gsub(/#{c}/i, ''), reg).size}"
#end
