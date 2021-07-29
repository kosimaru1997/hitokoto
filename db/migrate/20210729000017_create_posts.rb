class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :post, null: false
      t.integer :score, null: false
      t.integer :magnitude, null: false
      t.integer :random_int1, null: false
      t.integer :random_int2, null: false

      t.timestamps
    end
  end
end
