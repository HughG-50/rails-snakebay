Snake.names.each do |name|
    Breed.create(name: name)
    puts "#{name} created"
end