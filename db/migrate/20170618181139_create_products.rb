class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :rating
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
