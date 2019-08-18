class User < ApplicationRecord
    has_secure_password
    has_many :rankings
    has_many :categories, through: :rankings
end
