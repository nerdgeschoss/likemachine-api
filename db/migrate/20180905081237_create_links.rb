class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links, id: :uuid do |t|
      t.string :title
      t.string :description
      t.string :image_url
      t.string :url, null: false
      t.uuid :author_id, null: false

      t.timestamps
    end
    add_foreign_key :links, :users, column: :author_id
  end
end
