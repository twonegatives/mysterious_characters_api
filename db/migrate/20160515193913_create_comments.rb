class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.references :character, index: true, foreign_key: true, null: false
      t.string :body, null: false

      t.timestamps null: false
    end
  end
end
