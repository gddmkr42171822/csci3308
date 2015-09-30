class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :user_id
      t.string :title
      t.string :location
      t.text :description


      t.timestamps
    end

	add_index :projects, [ :user_id, :created_at ]
  end
end
