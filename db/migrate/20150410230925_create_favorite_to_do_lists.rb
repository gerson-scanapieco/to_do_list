class CreateFavoriteToDoLists < ActiveRecord::Migration
  def change
    create_table :favorite_to_do_lists do |t|
      t.integer :user_id      
      t.integer :to_do_list_id
      
      t.timestamps null: false
    end
  end
end
