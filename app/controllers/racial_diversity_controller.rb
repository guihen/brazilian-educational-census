class RacialDiversityController < ApplicationController
  def index
    @racial_diversity = sum_racial_diversity(School.pluck(:racial_diversity))
    @racial_diversity_region_norte = sum_racial_diversity(School.where(region: "Norte").pluck(:racial_diversity))
  end

  private

  def sum_racial_diversity(scope)
    SumRacialDiversity.new(scope).call
  end
end
