require "application_system_test_case"

# Uses the number format to validates correclty the content of the page
include ActionView::Helpers::NumberHelper

class RacialDiversityTest < ApplicationSystemTestCase
  setup do
    schools(:rondonia, :acre)
    schools(:sao_paulo, :espirito_santo)
    schools(:sao_paulo_albino_cesar, :sao_paulo_philomena_baylao_profa, :sao_paulo_prof_rafael_de_morais_lima)
    schools(:bahia)
    schools(:parana)
    schools(:goias)
  end

  test "should have a title with the given region" do
    region_to_be_tested_1 = "norte"
    region_to_be_tested_2 = "sul"

    visit racial_diversity_by_region_url(region_to_be_tested_1)

    assert_text "Diversidade regional de raça/cor - Região Norte"

    visit racial_diversity_by_region_url(region_to_be_tested_2)

    assert_text "Diversidade regional de raça/cor - Região Sul"
  end

  test "should have the racial diversity total only for the given region" do
    racial_diversities = School.where(region: "Norte").pluck(:racial_diversity)
    expected_result = SumRacialDiversity.new(racial_diversities).call
    region_to_be_tested = "norte"

    visit racial_diversity_by_region_url(region_to_be_tested)

    within(id: "nao-declarado-regiao-norte") do
      assert_text number_with_delimiter(expected_result["nao_declarado"])
    end

    within(id: "branca-regiao-norte") do
      assert_text number_with_delimiter(expected_result["branca"])
    end

    within(id: "parda-regiao-norte") do
      assert_text number_with_delimiter(expected_result["parda"])
    end

    within(id: "preta-regiao-norte") do
      assert_text number_with_delimiter(expected_result["preta"])
    end

    within(id: "amarela-regiao-norte") do
      assert_text number_with_delimiter(expected_result["amarela"])
    end

    within(id: "indigena-regiao-norte") do
      assert_text number_with_delimiter(expected_result["indigena"])
    end
  end

  test "should have the racial diversity grouped by 'setor' according zipcode" do
    query_result = School.where(region: "Sudeste").pluck(:code, :racial_diversity)
    school_codes_from_the_same_section = [35001193, 35001173, 35001181]
    group_criteria = "023"
    records_to_be_grouped = query_result.select! do |result|
      school_codes_from_the_same_section.include?(result[0])
    end
    expected_result = SumRacialDiversity.new(records_to_be_grouped.map(&:last)).call
    region_to_be_tested = "sudeste"

    visit racial_diversity_by_region_url(region_to_be_tested)

    within(id: "nao-declarado-setor-#{group_criteria}") do
      assert_text number_with_delimiter(expected_result["nao_declarado"])
    end

    within(id: "branca-setor-#{group_criteria}") do
      assert_text number_with_delimiter(expected_result["branca"])
    end

    within(id: "parda-setor-#{group_criteria}") do
      assert_text number_with_delimiter(expected_result["parda"])
    end

    within(id: "preta-setor-#{group_criteria}") do
      assert_text number_with_delimiter(expected_result["preta"])
    end

    within(id: "amarela-setor-#{group_criteria}") do
      assert_text number_with_delimiter(expected_result["amarela"])
    end

    within(id: "indigena-setor-#{group_criteria}") do
      assert_text number_with_delimiter(expected_result["indigena"])
    end
  end
end
