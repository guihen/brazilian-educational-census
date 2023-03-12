require 'csv'

class SchoolDto
  def initialize(data, line_parser = CSV)
    @data = data
    @parser = line_parser
  end

  def code
    parsed_data[13]
  end

  def name
    parsed_data[14]
  end

  def region
    parsed_data[1]
  end

  def state
    parsed_data[3]
  end

  def county
    parsed_data[6]
  end

  def zipcode
    parsed_data[23] || "00000000"
  end

  def census_year
    parsed_data[0].to_i
  end

  def racial_diversity
    {
      nao_declarado: parsed_data[316].to_i,
      branca: parsed_data[317].to_i,
      preta: parsed_data[318].to_i,
      parda: parsed_data[319].to_i,
      amarela: parsed_data[320].to_i,
      indigena: parsed_data[321].to_i
    }
  end

  private

  def parsed_data
    @parsed_data ||= @parser.parse_line(@data, col_sep: ';')
  end
end
