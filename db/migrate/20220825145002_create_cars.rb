class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.timestamps
      t.string :name, null: false
      t.integer :condition, default: 0
      t.integer :year, null: false
      t.decimal :price, precision: 15, scale: 2
      t.references :dealership, foreign_key: { on_delete: :cascade }
    end
  end
end
