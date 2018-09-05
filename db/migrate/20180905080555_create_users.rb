class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :facebook_token, null: false

      t.timestamps
    end
    add_index :users, :facebook_token
  end
end
