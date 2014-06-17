class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :content
      t.string :section
      t.string :date_created
      t.string :date_completed

      t.timestamps
    end
  end
end
