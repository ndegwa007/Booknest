require 'net/http'
require 'json'

class BookImporter
  def self.import_from_open_library(subject = "fiction", limit = 10)
    url = URI("https://openlibrary.org/subjects/#{subject}.json?limit=#{limit}")
    response = Net::HTTP.get(url)
    data = JSON.parse(response)
    
    data["works"].each do |work|
      # Get more details about the book
      book_url = URI("https://openlibrary.org#{work['key']}.json")
      book_response = Net::HTTP.get(book_url)
      book_data = JSON.parse(book_response)
      
      # Get cover image URL (using cover ID if available)
      cover_id = book_data['covers']&.first
      cover_url = cover_id ? "https://covers.openlibrary.org/b/id/#{cover_id}-L.jpg" : nil

      # Create book if it doesn't exist
      Book.find_or_create_by!(isbn: work['key']) do |book|
        book.title = work['title']
        book.author = work['authors']&.first&.dig('name') || 'Unknown Author'
        book.status = 'available'
        book.cover_image_url = cover_url
        book.description = book_data['description'].is_a?(Hash) ? 
                          book_data['description']['value'] : 
                          book_data['description']
      end
    rescue StandardError => e
      Rails.logger.error "Failed to import book: #{work['title']} - #{e.message}"
    end
  end
end 