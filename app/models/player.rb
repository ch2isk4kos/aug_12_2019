class Player < ApplicationRecord
    has_many :selections
    has_many :rankings, through: :selections

    scope :alphabetical_order, -> { order(:name) }
    scope :positions, -> { where("postion = ?", true ).uniq }

end
