class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :password_digest, null: false
      t.string :slug, null: false
      t.datetime :discarded_at

      t.timestamps

      t.index :name, unique: true
      t.index :slug, unique: true
    end
  end
end
