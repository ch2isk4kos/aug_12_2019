class Player < ApplicationRecord
    has_many :selections
    has_many :rankings, through: :selections
end
