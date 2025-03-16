# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Open and read the file "engine_names.txt" from the root directory
File.open(Rails.root.join("engine_names.txt"), "r").each_line do |line|
  engine_name = line.strip # Remove any leading/trailing whitespace
  next if engine_name.blank? # Skip blank lines

  # Create a new Engine record if it doesn't already exist
  Engine.find_or_create_by(name: engine_name)
end

puts "Engines seeded successfully!"
