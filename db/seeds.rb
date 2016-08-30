10.times do 
  User.create(
    email: Faker::Internet.email, 
    password: Faker::Internet.password(8), 
    name: Faker::Superhero.name
    )
  Question.create(
    title: Faker::StarWars.quote,
    content: Faker::Hacker.say_something_smart
    )
  # Category.create(
  #   name: Faker::Hipster.word
  #   )
end



counter = 1
Question.all.each do |q|

  q.categories << [Category.new(name: Faker::Hipster.word), Category.new(name: Faker::Hipster.word)]
  q.answers << [Answer.new(content: Faker::Lorem.paragraph(2, false, 4), user_id: counter), Answer.new(content: Faker::Lorem.paragraph(2, false, 4), user_id: counter)]
  

  q.user_id = counter
  q.save
  counter += 1
end