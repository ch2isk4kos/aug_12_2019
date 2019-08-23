class User < ApplicationRecord

    # bcrypt password encryption
    has_secure_password

    # associations
    has_many :rankings
    has_many :categories, through: :rankings

    # called in sessions#google_auth
    def self.from_omniauth(auth)
        where(email: auth.info.email).first_or_initialize do |user|
            user.username = auth.info.name
            user.email = auth.info.email
            user.password = SecureRandom.hex
        end
    end

end
