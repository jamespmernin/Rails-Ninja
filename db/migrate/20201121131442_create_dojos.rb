class CreateDojos < ActiveRecord::Migration[6.0]
  def change
    create_table :dojos do |t|
      t.string :name
      t.text :motto

      t.timestamps
    end
  end
end
