class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.text :description

      t.references :created_by, null: false, foreign_key: { to_table: :users }
      t.references :assigned_to, foreign_key: { to_table: :users }
      t.references :visible_up_to, foreign_key: { to_table: :groups }

      t.integer :urgency, null: false, default: 2 # default to 'mid'
      t.integer :status, null: false, default: 0  # default to 'unassigned'

      t.datetime :assigned_on
      t.datetime :completed_on

      t.timestamps # created_at and updated_at
    end
  end
end