class AddUniqueIndexToUsersEmail < ActiveRecord::Migration[8.0]
  def change
    remove_index :users, :email if index_exists?(:users, :email) # Remove existing index
    add_index :users, "lower(email)", unique: true, name: "index_users_on_lower_email"
  end
end
