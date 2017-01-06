class AddDefaultValueToRevealed < ActiveRecord::Migration[5.0]
  def change
    change_column :cards, :revealed, :boolean, :default => false
  end
end
