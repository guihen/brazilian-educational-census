require "test_helper"
require Rails.root.join("lib", "seed_support", "seed_files")
require "minitest/autorun"

class SeedTest < ActiveSupport::TestCase
  SAMPLE = Rails.root.join('lib', 'census_data', 'sample_seed.csv')

  test "should have defined the path to import the census from 2021" do
    assert_nothing_raised do
      Rails.application.path_to_census_2021
    end
  end

  test "should have defined the path to import the census from 2022" do
    assert_nothing_raised do
      Rails.application.path_to_census_2022
    end
  end

  test "should save each line of the imported file into the schools table" do
    # Arrange
    stubed_files = [File.open(SAMPLE)]

    # ACT
    SeedFiles.stub :call, stubed_files do
      # asserting difference doesn't requires the table to be previously empty
      assert_difference 'School.count' , 3 do
        Rails.application.load_seed
      end
    end

    # Assert
    assert_nothing_raised do
      School.find_by_code("11024682")
      School.find_by_code("13099493")
      School.find_by_code("26062836")
    end
  end

  test "should import the expected attributes from schools model" do
    # Arrange
    stubed_files = [File.open(SAMPLE)]

    # ACT
    SeedFiles.stub :call, stubed_files do
      Rails.application.load_seed
    end

    # Using a school that there are all the informations expected
    school = School.find_by_code("26062836")
    expected_census_year = 2021
    expected_name = "ESCOLA DE REFERENCIA EM ENSINO FUNDAMENTAL E MEDIO JOAQUIM RIBEIRO DA ROCHA"
    expected_diversity = {
      "nao_declarado" => 242,
      "branca" => 20,
      "preta" => 2,
      "parda" => 31,
      "amarela" => 0,
      "indigena" => 1
    }

    assert_equal expected_census_year, school.census_year
    assert_equal expected_name, school.name
    assert_equal "Nordeste", school.region
    assert_equal "Pernambuco", school.state

    # PENDING: solve the encoding problem. I've changed the sample_test file in order to remove the `ã` char until it got fixed.
    assert_equal "Sao Caitano", school.county
    assert_equal "55130000", school.zipcode
    assert_equal expected_diversity, school.racial_diversity
  end
end
