class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :name
      t.string :description
      t.integer :to_do_list_id

      t.timestamps null: false
    end
  end
end
