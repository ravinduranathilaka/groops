class CreateGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.references :parent, foreign_key: { to_table: :groups }

      t.timestamps
    end
  end
end