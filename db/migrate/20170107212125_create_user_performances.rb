class CreateUserPerformances < ActiveRecord::Migration[5.0]
  def change
    create_table :user_performances do |t|
      t.integer :user_id
      t.integer :wins,          default: 0
      t.integer :losses,        default: 0
      t.float :win_loss_ratio,  default: 0

      t.timestamps
    end
  end
end
