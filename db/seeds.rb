# db/seeds.rb
# Clear existing data
puts "Clearing existing data..."
Borrowing.destroy_all  # Delete borrowings first since they depend on books
Book.destroy_all

# Import books from different categories
puts "Importing new books..."
[ "fiction", "mystery", "science" ].each do |subject|
  puts "Importing #{subject} books..."
  BookImporter.import_from_open_library(subject, 5)
end

puts "Seed completed successfully!"
