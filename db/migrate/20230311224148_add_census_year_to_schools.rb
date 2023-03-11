class AddCensusYearToSchools < ActiveRecord::Migration[7.0]
  def change
    add_column :schools, :census_year, :integer
    add_index :schools, :census_year
  end
end
