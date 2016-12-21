class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.integer :game_id
      t.string :content
      t.string :state
      t.integer :position
      t.boolean :matched, default: false

      t.timestamps
    end
  end
end
