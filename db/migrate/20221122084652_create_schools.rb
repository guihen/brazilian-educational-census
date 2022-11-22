class CreateSchools < ActiveRecord::Migration[7.0]
  def change
    create_table :schools do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.string :region, null: false
      t.string :state, null: false
      t.string :county, null: false
      t.string :zipcode, null: false

      t.timestamps
    end
    add_index :schools, :code
  end
end
