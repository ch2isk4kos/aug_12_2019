class Ranking < ApplicationRecord
    belongs_to :user
    has_many :selections
    has_many :players, through: :selections
end
