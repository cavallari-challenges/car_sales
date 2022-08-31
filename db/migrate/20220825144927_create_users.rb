class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.timestamps
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :name, null: false
      t.integer :role, default: 0
    end

    add_index :users, :email, unique: true
  end
end
