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
    assert_difference 'School.count' , 3 do
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
      School.find_by_code("26062836")
    end
  end

  test "should import the expected attributes from schools model" do
    previous_value = Rails.application.path_to_census_2021
    Rails.application.define_singleton_method(:path_to_census_2021) do
      SAMPLE
    end

    Rails.application.load_seed

    Rails.application.define_singleton_method(:path_to_census_2021) do
      previous_value
    end

    # Using a school that there are all the informations expected
    school = School.find_by_code("26062836")
    expected_name = "ESCOLA DE REFERENCIA EM ENSINO FUNDAMENTAL E MEDIO JOAQUIM RIBEIRO DA ROCHA"
    expected_diversity = {
      "nao_declarado" => 242,
      "branca" => 20,
      "preta" => 2,
      "parda" => 31,
      "amarela" => 0,
      "indigena" => 1
    }

    assert_equal expected_name, school.name
    assert_equal "Nordeste", school.region
    assert_equal "Pernambuco", school.state
    assert_equal "São Caitano", school.county
    assert_equal "55130000", school.zipcode
    assert_equal expected_diversity, school.racial_diversity
  end
end
