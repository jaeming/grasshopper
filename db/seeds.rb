require 'faker'

8.times do
  user = User.create!(
  name:      Faker::Name.name,
  email:     Faker::Internet.email,
  password:  Faker::Lorem.characters(10)
  )
  user.save!
end
users = User.all

10.times do
  Board.create!(
    user: users.sample,
    title: Faker::Lorem.sentence,
    text:  Faker::Lorem.paragraph
    )
end
boards = Board.all

100.times do
  Message.create!(
    user: users.sample,
    board: boards.sample,
    body: Faker::Lorem.paragraph
    )
end

puts "Seeds generated"
puts "#{Board.count} Board posts created"
puts "#{Message.count} Messages created"
