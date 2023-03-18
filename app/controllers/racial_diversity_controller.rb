class RacialDiversityController < ApplicationController
  def index
    @racial_diversity_2021 = Hash.new.tap do |hash|
      hash["Total"] = CalculatedRacialDiversity.find_by_slug('totals_2021').value
      hash["Norte"] = sum_racial_diversity(scope_for_2021.where(region: "Norte").pluck(:racial_diversity))
      hash["Nordeste"] = sum_racial_diversity(scope_for_2021.where(region: "Nordeste").pluck(:racial_diversity))
      hash["Centro-Oeste"] = sum_racial_diversity(scope_for_2021.where(region: "Centro-Oeste").pluck(:racial_diversity))
      hash["Sudeste"] = sum_racial_diversity(scope_for_2021.where(region: "Sudeste").pluck(:racial_diversity))
      hash["Sul"] = sum_racial_diversity(scope_for_2021.where(region: "Sul").pluck(:racial_diversity))
    end

    @racial_diversity_2022 = Hash.new.tap do |hash|
      hash["Total"] = CalculatedRacialDiversity.find_by_slug('totals_2022').value
      hash["Norte"] = sum_racial_diversity(scope_for_2022.where(region: "Norte").pluck(:racial_diversity))
      hash["Nordeste"] = sum_racial_diversity(scope_for_2022.where(region: "Nordeste").pluck(:racial_diversity))
      hash["Centro-Oeste"] = sum_racial_diversity(scope_for_2022.where(region: "Centro-Oeste").pluck(:racial_diversity))
      hash["Sudeste"] = sum_racial_diversity(scope_for_2022.where(region: "Sudeste").pluck(:racial_diversity))
      hash["Sul"] = sum_racial_diversity(scope_for_2022.where(region: "Sul").pluck(:racial_diversity))
    end
  end

  private

  def scope_for_2021
    School.where(census_year: 2021)
  end

  def scope_for_2022
    School.where(census_year: 2022)
  end

  def sum_racial_diversity(scope)
    SumRacialDiversity.new(scope).call
  end
end
