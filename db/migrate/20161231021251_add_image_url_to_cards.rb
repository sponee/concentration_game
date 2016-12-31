class AddImageUrlToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :image_url, :string
  end
end
