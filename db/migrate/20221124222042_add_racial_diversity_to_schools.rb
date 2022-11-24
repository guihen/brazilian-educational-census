class AddRacialDiversityToSchools < ActiveRecord::Migration[7.0]
  def change
    add_column :schools, :racial_diversity, :json
  end
end
