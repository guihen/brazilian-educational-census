require "application_system_test_case"

class BrazilTest < ApplicationSystemTestCase
  setup do
    schools(:rondonia, :acre)
    schools(:sao_paulo, :espirito_santo)
    schools(:bahia)
    schools(:parana)
    schools(:goias)
  end

  test "should show the the total of schools" do
    total_schools = School.count

    visit brazil_show_url

    assert_text total_schools
  end

  test "should have the total schools grouped by region" do
    total_schools_by_region = School.group(:region).count

    visit brazil_show_url

    assert_text "Região Norte: #{total_schools_by_region["Norte"]}"
    assert_text "Região Nordeste: #{total_schools_by_region["Nordeste"]}"
    assert_text "Região Centro-Oeste: #{total_schools_by_region["Centro-Oeste"]}"
    assert_text "Região Sudeste: #{total_schools_by_region["Sudeste"]}"
    assert_text "Região Sul: #{total_schools_by_region["Sul"]}"
  end
end
