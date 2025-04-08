namespace :books do
  desc "Import books from Open Library API"
  task :import, [ :subject, :limit ] => :environment do |t, args|
    subject = args[:subject] || "fiction"
    limit = (args[:limit] || 10).to_i

    puts "Importing #{limit} books from '#{subject}' category..."
    BookImporter.import_from_open_library(subject, limit)
    puts "Import completed!"
  end
end
