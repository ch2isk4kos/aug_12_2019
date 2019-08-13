class Selection < ApplicationRecord
    belongs_to :ranking
    belongs_to :player

    accepts_nested_attributes_for :player

    # In order for a Selection to create a new player
    # it needs a writer to handle the permitable attribute(s):
    #
    #   selections_attributes = [
    #       player_attributes: [:name, :position, :number]
    #   ]
    # ]

    def player_attributes=(player_params)
        if !player_params['name'].empty?
            self.player = Player.find_or_create_by(player_params)
        end
    end
    
end
