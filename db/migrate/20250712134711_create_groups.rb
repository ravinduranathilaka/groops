class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :name
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end