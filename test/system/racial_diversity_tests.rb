require "application_system_test_case"

# Uses the number format to validates correclty the content of the page
include ActionView::Helpers::NumberHelper

class RacialDiversityTest < ApplicationSystemTestCase
  test "should have the racial diversity accumulated for Brazil" do
    racial_diversity_totals = School.pluck(:racial_diversity).reduce(Hash.new(0)) do |accumulated, racial_diversity|
      {
        "nao_declarado" => accumulated["nao_declarado"] + racial_diversity["nao_declarado"],
        "branca" => accumulated["branca"] + racial_diversity["branca"],
        "parda" => accumulated["parda"] + racial_diversity["parda"],
        "preta" => accumulated["preta"] + racial_diversity["preta"],
        "amarela" => accumulated["amarela"] + racial_diversity["amarela"],
        "indigena" => accumulated["indigena"] + racial_diversity["indigena"]
      }
    end

    visit racial_diversity_index_url

    within(id: "nao-declarado-brazil") do
        assert_text number_with_delimiter(racial_diversity_totals["nao_declarado"])
    end

    within(id: "branca-brazil") do
      assert_text number_with_delimiter(racial_diversity_totals["branca"])
    end

    within(id: "parda-brazil") do
      assert_text number_with_delimiter(racial_diversity_totals["parda"])
    end

    within(id: "preta-brazil") do
      assert_text number_with_delimiter(racial_diversity_totals["preta"])
    end

    within(id: "amarela-brazil") do
      assert_text number_with_delimiter(racial_diversity_totals["amarela"])
    end

    within(id: "indigena-brazil") do
      assert_text number_with_delimiter(racial_diversity_totals["indigena"])
    end
  end

  test "should have the racial diversity for the region Norte" do
    racial_diversity_by_region = School.where(region: "Norte").pluck(:racial_diversity).reduce(Hash.new(0)) do |memo, racial_diversity|
      {
        "nao_declarado" => memo["nao_declarado"] + racial_diversity["nao_declarado"],
        "branca" => memo["branca"] + racial_diversity["branca"],
        "parda" => memo["parda"] + racial_diversity["parda"],
        "preta" => memo["preta"] + racial_diversity["preta"],
        "amarela" => memo["amarela"] + racial_diversity["amarela"],
        "indigena" => memo["indigena"] + racial_diversity["indigena"]
      }
    end

    visit racial_diversity_index_url

    within(id: "nao-declarado-regiao-norte") do
        assert_text number_with_delimiter(racial_diversity_by_region["nao_declarado"])
    end

    within(id: "branca-regiao-norte") do
      assert_text number_with_delimiter(racial_diversity_by_region["branca"])
    end

    within(id: "parda-regiao-norte") do
      assert_text number_with_delimiter(racial_diversity_by_region["parda"])
    end

    within(id: "preta-regiao-norte") do
      assert_text number_with_delimiter(racial_diversity_by_region["preta"])
    end

    within(id: "amarela-regiao-norte") do
      assert_text number_with_delimiter(racial_diversity_by_region["amarela"])
    end

    within(id: "indigena-regiao-norte") do
      assert_text number_with_delimiter(racial_diversity_by_region["indigena"])
    end
  end
end
