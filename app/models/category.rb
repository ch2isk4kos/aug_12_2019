class Category < ApplicationRecord
    has_many :rankings
    has_many :users, through: :rankings

    scope :most_popular, -> { joins(:rankings).where("category_id = ?", true).first.title }
    

end
