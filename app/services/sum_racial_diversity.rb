class SumRacialDiversity
  def initialize(racial_diversities)
    @racial_diversities = racial_diversities
  end

  def call
    @racial_diversities.reduce(Hash.new(0)) do |memo, racial_diversity|
      {
        "nao_declarado" => memo["nao_declarado"] + racial_diversity["nao_declarado"],
        "branca" => memo["branca"] + racial_diversity["branca"],
        "parda" => memo["parda"] + racial_diversity["parda"],
        "preta" => memo["preta"] + racial_diversity["preta"],
        "amarela" => memo["amarela"] + racial_diversity["amarela"],
        "indigena" => memo["indigena"] + racial_diversity["indigena"]
      }
    end
  end
end
