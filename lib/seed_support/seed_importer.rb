# abstracts the import algorith. It is specially usefull for run automated tests
class SeedImporter
  def self.call(file)
    headers = CSV.parse_line(file.readline, col_sep: ';')

    School.transaction do
      file.each do |line|
        values = CSV.parse_line(line, col_sep: ';')
        csv_row = CSV::Row.new(headers, values)

        SchoolDto.new(csv_row).tap do |dto|
          School.create({
            census_year: dto.census_year,
            code: dto.code,
            name: dto.name,
            region: dto.region,
            state: dto.state,
            county: dto.county,
            zipcode: dto.zipcode,
            racial_diversity: dto.racial_diversity
          })
        end
      end
    end
  end
end