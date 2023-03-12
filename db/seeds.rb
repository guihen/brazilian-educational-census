require Rails.root.join('lib', 'census_data', 'school_dto')
require Rails.root.join('lib', 'seed_support', 'seed_files')
require Rails.root.join('lib', 'seed_support', 'seed_importer')
require Rails.root.join('lib', 'seed_support', 'seed_printer')

# shows elapsed time prettier
include ActionView::Helpers::DateHelper
start_time = Time.now

SeedFiles.call.each do |file|
  SeedPrinter.call "Importing file #{file.path}. It may take a while..."

  SeedImporter.call(file)
end

SeedPrinter.call "Seeds imported. Total of #{School.count} records"
SeedPrinter.call "Elapsed time: #{ActionView::Helpers::DateHelper::distance_of_time_in_words(start_time, Time.now)}"

