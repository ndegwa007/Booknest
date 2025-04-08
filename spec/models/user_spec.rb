

# Associations

# Ensures a user has many borrowings.
# Ensures a user has many borrowed books through borrowings.

# Validations

# Ensures email is present.
# Ensures email is unique (case insensitive).

# Password Security

# Verifies has_secure_password encrypts the password.
# Ensures only the correct password authenticates the user.

require 'rails_helper'

RSpec.describe User, type: :model do
  describe "associations" do
    it { should have_many(:borrowings) }
    it { should have_many(:borrowed_books).through(:borrowings).source(:book) }
  end

  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  describe "password security" do
    it "encrypts the password" do
      user = User.create(email: "test@example.com", password: "password123", password_confirmation: "password123")
      expect(user.authenticate("password123")).to eq(user)
      expect(user.authenticate("wrongpassword")).to be_falsey
    end
  end
end
