class CreateStatuses < ActiveRecord::Migration[5.0]
  safety_assured

  def change
    create_table :statuses do |t|
      t.string :name, null: false
      t.integer :position, null: false
      t.string :category, null: false

      t.references :project, type: :uuid, foreign_key: true, index: true, null: false

      t.timestamps
    end

    add_index :statuses, [:name, :project_id], unique: true
  end
end
