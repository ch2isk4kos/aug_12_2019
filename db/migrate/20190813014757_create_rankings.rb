class CreateRankings < ActiveRecord::Migration[5.2]
  def change
    create_table :rankings do |t|
      t.text :content
      t.integer :user_id
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
