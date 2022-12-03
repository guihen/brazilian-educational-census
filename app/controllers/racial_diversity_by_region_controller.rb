class RacialDiversityByRegionController < ApplicationController
  def show
    query_result = School.where(query).pluck(:racial_diversity)

    @racial_diversity = SumRacialDiversity.new(query_result).call
    @region = params[:region].capitalize

    @setor_groups = group_by_setor(School.where(query))
  end

  private

  def group_by_setor(criteria)
    GroupBySetor.new(criteria).call
  end

  def query
    case params[:region]
    when 'norte'
      { region: 'Norte' }
    when 'nordeste'
      { region: 'Nordeste' }
    when 'centro-oeste'
      { region: 'Centro-Oeste' }
    when 'sudeste'
      { region: 'Sudeste' }
    when 'sul'
      { region: 'Sul' }
    else
      false
    end
  end
end
