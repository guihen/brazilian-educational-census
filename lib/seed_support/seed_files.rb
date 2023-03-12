# abstracts the amount of files used on this project
class SeedFiles
  def self.call
    [
      File.open(Rails.application.path_to_census_2021, :encoding => 'iso-8859-1:utf-8'),
      File.open(Rails.application.path_to_census_2022, :encoding => 'iso-8859-1:utf-8')
    ]
  end
end
