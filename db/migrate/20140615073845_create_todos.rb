class CreateTodos < ActiveRecord::Migration[4.2]
  def change
    create_table :todos do |t|
      t.string :content
      t.string :section
      t.boolean :completed

      t.timestamps
    end
  end
end
