class User < ApplicationRecord
    has_secure_password # adds password encryption and authentication
    validates :email, presence: true, uniqueness: true
end
