class CreateSenseis < ActiveRecord::Migration[6.0]
  def change
    create_table :senseis do |t|
      t.string :name
      t.string :image_url
      t.text :wise_quote
      t.references :dojo, null: false, foreign_key: true

      t.timestamps
    end
  end
end
