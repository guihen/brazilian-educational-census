class BrazilController < ApplicationController
  def show
    @total_schools = School.all.count
    @total_schools_by_region = School.group(:region).count
    @racial_diversity_totals = School.pluck(:racial_diversity).reduce(Hash.new(0)) do |accumulated, racial_diversity|
      {
        "nao_declarado" => accumulated["nao_declarado"] + racial_diversity["nao_declarado"],
        "branca" => accumulated["branca"] + racial_diversity["branca"],
        "parda" => accumulated["parda"] + racial_diversity["parda"],
        "preta" => accumulated["preta"] + racial_diversity["preta"],
        "amarela" => accumulated["amarela"] + racial_diversity["amarela"],
        "indigena" => accumulated["indigena"] + racial_diversity["indigena"]
      }
    end
  end
end
