class CreateToDoLists < ActiveRecord::Migration
  def change
    create_table :to_do_lists do |t|
      t.string :name
      t.integer :user_id
      t.integer :list_type, default: 1

      t.timestamps null: false
    end
  end
end
