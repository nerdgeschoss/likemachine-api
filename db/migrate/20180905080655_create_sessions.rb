class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions, id: :uuid do |t|
      t.uuid :user_id, null: false

      t.timestamps
    end
    add_foreign_key :sessions, :users
  end
end
