require 'csv'

class SchoolDto
  def initialize(raw_data)
    @raw_data = raw_data
  end

  def name
    parsed_data = CSV.parse_line(@raw_data, col_sep: ';')
    parsed_data[14]
  end

  def region
    parsed_data = CSV.parse_line(@raw_data, col_sep: ';')
    parsed_data[1]
  end

  def state
    parsed_data = CSV.parse_line(@raw_data, col_sep: ';')
    parsed_data[3]
  end

  def county
    parsed_data = CSV.parse_line(@raw_data, col_sep: ';')
    parsed_data[6]
  end

  def zipcode
    parsed_data = CSV.parse_line(@raw_data, col_sep: ';')
    parsed_data[23]
  end
end
