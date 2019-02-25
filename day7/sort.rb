def sort(letters, count= 0)
  sorted_letters = letters.sort do |a, b|
    #binding.pry
    if a.last.include?(b.first)
      puts "'#{a.first}' <=> '#{b.first}'...1"
      1
    elsif b.last.include?(a.first)
      puts "'#{a.first}' <=> '#{b.first}'...-1"
      -1
    else
      a.first <=> b.first
    end
  end
  puts count += 1
  letters_str = str_from(letters)
  return letters_str if letters_str == str_from(sorted_letters)
  sort(sorted_letters, count)
end

def str_from(letters)
  letters.map {|k, _v| k }.join
end
