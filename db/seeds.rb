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
# db/seeds.rb
# db/seeds.rb

Task.create([
  {
    title: "Junior assessment – Ruby on Rails developer",
    description: "Build a simple Task Manager using Rails 7+ with Hotwire.",
    completed: false
  },
  {
    title: "CRUD functionality",
    description: "Full CRUD with RESTful routes and Turbo interactions.",
    completed: false
  },
  {
    title: "Turbo Frames",
    description: "Enable inline task editing on the list page.",
    completed: false
  },
  {
    title: "Turbo Streams",
    description: "Update the task list in real-time on create/delete.",
    completed: false
  },
  {
    title: "Frames & Streams",
    description: "Render new tasks and broadcast additions.",
    completed: false
  },
  {
    title: "Stimulus controller",
    description: "Toggle task completion with form submit.",
    completed: false
  },
  {
    title: "Bonus",
    description: "Client-side validations and optional Tailwind styling.",
    completed: false
  },
  {
    title: "Environment",
    description: "Ruby 3.2+, Rails 7+, PostgreSQL, Hotwire enabled.",
    completed: false
  },
  {
    title: "Seed data & instructions",
    description: "Provide example tasks and setup instructions.",
    completed: false
  }
])
