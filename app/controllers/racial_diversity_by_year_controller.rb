class RacialDiversityByYearController < ApplicationController
  def show
    @year = params["year"]
    @racial_diversity = Hash.new.tap do |hash|
      hash["Total"] = CalculatedRacialDiversity.find_by_slug("totals_#{@year}").value
      hash["Norte"] = sum_racial_diversity(relation.where(region: "Norte").pluck(:racial_diversity))
      hash["Nordeste"] = sum_racial_diversity(relation.where(region: "Nordeste").pluck(:racial_diversity))
      hash["Centro-Oeste"] = sum_racial_diversity(relation.where(region: "Centro-Oeste").pluck(:racial_diversity))
      hash["Sudeste"] = sum_racial_diversity(relation.where(region: "Sudeste").pluck(:racial_diversity))
      hash["Sul"] = sum_racial_diversity(relation.where(region: "Sul").pluck(:racial_diversity))
    end
  end

  private
  def relation
    School.where(census_year: params["year"])
  end

  def sum_racial_diversity(scope)
    SumRacialDiversity.new(scope).call
  end
end
