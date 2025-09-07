# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

Task.create(title: "Buy groceries", description: "Milk, Eggs, Bread", completed: false)
Task.create(title: "Clean room", description: "Vacuum and organize shelves", completed: true)
Task.create(title: "Finish Rails project", description: "Submit by Friday", completed: false)
Task.create(title: "Read a book", description: "Finish reading 'Ruby on Rails Tutorial'", completed: true)
