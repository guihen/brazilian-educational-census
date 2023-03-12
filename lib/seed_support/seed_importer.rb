# abstracts the import algorith. It is specially usefull for run automated tests
class SeedImporter
  def self.call(file)
    # ignore the header
    file.readline

    School.transaction do
      file.each do |line|
        SchoolDto.new(line).tap do |dto|
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