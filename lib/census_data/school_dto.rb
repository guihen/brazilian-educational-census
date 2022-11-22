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
    parsed_data[23]
  end

  private

  def parsed_data
    @parsed_data ||= @parser.parse_line(@data, col_sep: ';')
  end
end
