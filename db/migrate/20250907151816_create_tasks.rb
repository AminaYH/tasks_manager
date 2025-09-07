class CreateTasks < ActiveRecord::Migration[7.1]
  def up
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :description
      t.boolean :completed, default: false, null: false

      t.timestamps
    end
  end

  def down
    drop_table :tasks
  end
end
