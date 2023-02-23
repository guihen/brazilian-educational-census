class AddRacialDiversityToSchools < ActiveRecord::Migration[7.0]
  def change
    change_table(:schools) do |t|
      t.column :racial_diversity, :json
    end
  end
end
