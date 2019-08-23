class Category < ApplicationRecord
    has_many :rankings
    has_many :users, through: :rankings

    # scope :most_popular, -> { order(:title) }
    #
    scope :list, -> { joins(:rankings).where('category_id = ?', true) }

end
