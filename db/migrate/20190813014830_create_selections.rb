class CreateSelections < ActiveRecord::Migration[5.2]
  def change
    create_table :selections do |t|
      t.string :ranking_position
      t.integer :ranking_id
      t.integer :player_id
      t.belongs_to :ranking, foreign_key: true
      t.belongs_to :player, foreign_key: true

      t.timestamps
    end
  end
end
