require "test_helper"

class SeedTest < ActiveSupport::TestCase
  SAMPLE = Rails.root.join('lib', 'census_data', 'sample_seed.csv')

  test "should have defined the path to import the census from 2021" do
    assert_nothing_raised do
      Rails.application.path_to_census_2021
    end
  end

  test "should save each line of the imported file into the schools table" do
    # Arrange
    previous_value = Rails.application.path_to_census_2021
    Rails.application.define_singleton_method(:path_to_census_2021) do
      SAMPLE
    end

    # asserting difference doesn't requires the table to be previously empty
    assert_difference 'School.count' , 2 do
      # ACT
      Rails.application.load_seed
    end

    # TODO: create clean room instead of manually restore the app configurations
    Rails.application.define_singleton_method(:path_to_census_2021) do
      previous_value
    end

    # Assert
    assert_nothing_raised do
      School.find_by_code("11024682")
      School.find_by_code("13099493")
    end
  end
end
