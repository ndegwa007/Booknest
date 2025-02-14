class AddImageAndDescriptionToBooks < ActiveRecord::Migration[8.0]
  def change
    add_column :books, :cover_image_url, :string
    add_column :books, :description, :text
  end
end 