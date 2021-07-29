class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :post, null: false
      t.string :personality_title, null: false
      t.string :sentiment, null: false
      t.string :personality1, null: false
      t.string :personality2, null: false
      t.integer :score, null: false
      t.integer :magnitude, null: false
      t.integer :random_int1, null: false
      t.integer :random_int2, null: false

      t.timestamps
    end
  end
end
