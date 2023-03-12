require 'csv'

class SchoolDto
  def initialize(hash)
    @hash = hash
  end

  def code
    parse_data("CO_ENTIDADE")
  end

  def name
    parse_data("NO_ENTIDADE")
  end

  def region
    parse_data("NO_REGIAO")
  end

  def state
    parse_data("NO_UF")
  end

  def county
    parse_data("NO_MUNICIPIO")
  end

  def zipcode
    parse_data("CO_CEP") || "00000000"
  end

  def census_year
    parse_data("NU_ANO_CENSO").to_i
  end

  def racial_diversity
    {
      nao_declarado: parse_data("QT_MAT_BAS_ND").to_i,
      branca: parse_data("QT_MAT_BAS_BRANCA").to_i,
      preta: parse_data("QT_MAT_BAS_PRETA").to_i,
      parda: parse_data("QT_MAT_BAS_PARDA").to_i,
      amarela: parse_data("QT_MAT_BAS_AMARELA").to_i,
      indigena: parse_data("QT_MAT_BAS_INDIGENA").to_i
    }
  end

  private

  def parse_data(field)
    @hash[field]
  end
end
