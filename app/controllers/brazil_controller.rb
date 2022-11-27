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

    structure_to_be_processed = {
      "Norte" => Hash.new(0),
      "Nordeste" => Hash.new(0),
      "Centro-Oeste" => Hash.new(0),
      "Sudeste" => Hash.new(0),
      "Sul" => Hash.new(0)
    }
    @racial_diversity_grouped_by_region = School.pluck(:region, :racial_diversity).reduce(structure_to_be_processed) do |structure, record|
      if record[1].present?
        structure[record[0]].tap do |region_accumulator|
          region_accumulator["nao_declarado"] = region_accumulator["nao_declarado"] + record[1]["nao_declarado"]
          region_accumulator["branca"] = region_accumulator["branca"] + record[1]["branca"]
          region_accumulator["parda"] = region_accumulator["parda"] + record[1]["parda"]
          region_accumulator["preta"] = region_accumulator["preta"] + record[1]["preta"]
          region_accumulator["amarela"] = region_accumulator["amarela"] + record[1]["amarela"]
          region_accumulator["indigena"] = region_accumulator["indigena"] + record[1]["indigena"]
        end
      end

      structure
    end
  end
end
