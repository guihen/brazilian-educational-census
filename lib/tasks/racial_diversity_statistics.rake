namespace :racial_diversity do
  desc "Calculates and stores the totals of the entire country using 2022 census data"
  task totals_for_2022: [:environment] do
    School.where(census_year: 2022).pluck(:racial_diversity).tap do |racial_diversities|
      CalculatedRacialDiversity.create({
      description: "Totals for 2022",
        slug: "totals_2022",
        value: SumRacialDiversity.new(racial_diversities).call
      })
    end
  end

  desc "Calculates and stores the totals of the entire country using 2021 census data"
  task totals_for_2021: [:environment] do
    School.where(census_year: 2021).pluck(:racial_diversity).tap do |racial_diversities|
      CalculatedRacialDiversity.create({
        description: "Totals for 2021",
        slug: "totals_2021",
        value: SumRacialDiversity.new(racial_diversities).call
      })
    end
  end
end