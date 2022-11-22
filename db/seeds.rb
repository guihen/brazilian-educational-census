require Rails.root.join('lib', 'census_data', 'school_dto')

file_2021 = File.open(Rails.application.path_to_census_2021)

# ignore the header
file_2021.readline

file_2021.each do |line|
  dto = SchoolDto.new(line)
  record = School.new
  record.code = dto.code
  record.name = dto.name
  record.region = dto.region
  record.state = dto.state
  record.county = dto.county
  record.zipcode = dto.zipcode
  record.save
end
