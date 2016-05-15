class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name,       null: false
      t.integer :health,    null: false
      t.integer :strength,  null: false
      t.integer :user_id,   null: false

      t.index :user_id
      t.timestamps null: false
    end
  end
end
