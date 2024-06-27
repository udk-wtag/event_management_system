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

# Create some sample users
User.destroy_all
User.create(name: 'John Doe', email: 'john@example.com', password: 'password')
User.create(name: 'Jane Smith', email: 'jane@example.com', password: 'password')
User.create(name: 'Alice Johnson', email: 'alice@example.com', password: 'password')

Event.destroy_all
Event.create([
  { name: "Music Festival", location: "Central Park, NYC", price: 49.99 },
  { name: "Tech Conference", location: "San Francisco, CA", price: 199.99 },
  { name: "Art Exhibition", location: "Los Angeles, CA", price: 29.99 },
  { name: "Food Fair", location: "Austin, TX", price: 9.99 },
  { name: "Marathon", location: "Boston, MA", price: 0.00 },
  { name: "Book Signing", location: "Seattle, WA", price: 15.00 },
  { name: "Comedy Show", location: "Chicago, IL", price: 25.00 },
  { name: "Film Festival", location: "Sundance, UT", price: 100.00 },
  { name: "Yoga Retreat", location: "Boulder, CO", price: 300.00 },
  { name: "Startup Pitch", location: "Palo Alto, CA", price: 49.99 }
])

puts 'Seed data generated successfully!'
