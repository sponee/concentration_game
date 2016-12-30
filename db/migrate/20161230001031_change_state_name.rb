class ChangeStateName < ActiveRecord::Migration[5.0]
  def change
    rename_column :cards, :state, :revealed, default: false
  end
end
