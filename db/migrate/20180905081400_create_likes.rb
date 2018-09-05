class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes, id: :uuid do |t|
      t.uuid :user_id, null: false
      t.uuid :link_id, null: false

      t.timestamps
    end
    add_foreign_key :likes, :users
    add_foreign_key :likes, :links
    add_index :likes, [:user_id, :link_id], unique: true
  end
end
