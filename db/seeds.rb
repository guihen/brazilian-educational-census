require Rails.root.join('lib', 'census_data', 'school_dto')

# shows elapsed time prettier
include ActionView::Helpers::DateHelper

# avoids printing when the tests are running
class SeedPrinter
  def self.print(string)
    puts string unless Rails.env.test?
  end
end


file_2021 = File.open(Rails.application.path_to_census_2021, :encoding => 'utf-8')

# ignore the header
file_2021.readline

SeedPrinter.print 'Importing file and saving it. It may take a while...'
start_time = Time.now

School.transaction do
  file_2021.each do |line|
    SchoolDto.new(line).tap do |dto|
      School.create({
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

SeedPrinter.print "Importante successfully. Imported #{School.count} records"
SeedPrinter.print "Elapsed time: #{ActionView::Helpers::DateHelper::distance_of_time_in_words(start_time, Time.now)}"
