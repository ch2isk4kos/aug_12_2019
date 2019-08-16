class Ranking < ApplicationRecord
    belongs_to :user
    belongs_to :category
    has_many :selections
    has_many :players, through: :selections

    accepts_nested_attributes_for :selections
    accepts_nested_attributes_for :players

    def selections_attributes=(selection_params)
        selection_params.values.each do |selection_attribute|
            #if !selection_attribute.values.any?(&:empty?) && (!selection_attribute["player_attributes"]["name"].blank? || selection_attribute["player_id"])
                self.selections << Selection.create(selection_attribute)
            #end
        end
    end

    def players_attributes=(player_params)
        player_params.values.each do |player_attribute|
            self.players << Player.find_or_create_by(player_attribute) if !player_attribute['name'].empty?
        end
    end

end
