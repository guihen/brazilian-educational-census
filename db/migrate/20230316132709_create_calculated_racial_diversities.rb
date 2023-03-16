class CreateCalculatedRacialDiversities < ActiveRecord::Migration[7.0]
  def change
    create_table :calculated_racial_diversities do |t|
      t.json :value
      t.text :description
      t.string :slug

      t.timestamps
    end
    add_index :calculated_racial_diversities, :slug
  end
end
