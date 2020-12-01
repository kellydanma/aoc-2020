movies = {
  totoro: 5,
}

puts "Choose an options:"
choice = gets.chomp.downcase
case choice
when "add"
  puts "Add a movie title:"
  title = gets.chomp.downcase
  if movies[title.to_sym] == nil
    puts "How would you rate this film? 1 = bad, 5 = excellent"
    rating = gets.chomp.to_i
    if rating > 5
      rating = 5
      elif rating < 1
      rating = 1
    end
    movies[title.to_sym] = rating
    puts "Added!"
  else
    puts "Movie is already in database."
  end
when "update"
  puts "Select a movie to update:"
  title = gets.chomp.downcase
  if movies[title.to_sym] == nil
    puts "Movie doesn't exist in DB"
  else
    puts "How would you rate this film? 1 = bad, 5 = excellent"
    rating = gets.chomp.to_i
    if rating > 5
      rating = 5
      elif rating < 1
      rating = 1
    end
    movies[title.to_sym] = rating
    puts "Updated!"
  end
when "display"
  movies.each do |m, r|
    puts "#{m.capitalize}: #{r}/5"
  end
when "delete"
  puts "Select a movie to delete:"
  title = gets.chomp.downcase
  if movies[title.to_sym] == nil
    puts "Movie doesn't exist in DB"
  else
    movies.delete(title.to_sym)
  end
else
  puts "Error!"
end
