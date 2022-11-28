class RacialDiversityController < ApplicationController
  def index
    @racial_diversity = Hash.new
    @racial_diversity["Total"] = sum_racial_diversity(School.pluck(:racial_diversity))
    @racial_diversity["Norte"] = sum_racial_diversity(School.where(region: "Norte").pluck(:racial_diversity))
    @racial_diversity["Nordeste"] = sum_racial_diversity(School.where(region: "Nordeste").pluck(:racial_diversity))
    @racial_diversity["Centro-Oeste"] = sum_racial_diversity(School.where(region: "Centro-Oeste").pluck(:racial_diversity))
    @racial_diversity["Sudeste"] = sum_racial_diversity(School.where(region: "Sudeste").pluck(:racial_diversity))
    @racial_diversity["Sul"] = sum_racial_diversity(School.where(region: "Sul").pluck(:racial_diversity))
  end

  private

  def sum_racial_diversity(scope)
    SumRacialDiversity.new(scope).call
  end
end
