# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


user = User.create(email: "test@test.com", password: "password")

10.times do
  User.create(email: Faker::Internet.email, password: "password")
end

5.times do |i|
  Board.create(
    user:,
    name: "Board #{i + 1}"
  )
end

Board.find_each do |board|
  5.times { |i| List.create(board:, title: "List #{i + 1}", position: i) }

  board.reload.lists.each do |list|
    5.times { |i| Item.create(list:, title: "Item #{i + 1}", description: "Description for Item #{i + 1}") }
  end
end
