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

  test "should have the racial diversity grouped by region" do
    structure = {
      "Norte" => [],
      "Nordeste" => [],
      "Centro-Oeste" => [],
      "Sudeste" => [],
      "Sul" => []
    }
    racial_diversity_grouped_by_region = School.pluck(:region, :racial_diversity).reduce(structure) do |memo, record|
      memo[record.first] << record.last
      memo
    end

    racial_diversity_grouped_by_region.each do |region, racial_diversities|
      racial_diversity_grouped_by_region[region] = SumRacialDiversity.new(racial_diversities).call
    end

    visit racial_diversity_index_url

    within(id: "nao-declarado-regiao-nordeste") do
      assert_text number_with_delimiter(racial_diversity_grouped_by_region["Nordeste"]["nao_declarado"])
    end
    within(id: "branca-regiao-nordeste") do
      assert_text number_with_delimiter(racial_diversity_grouped_by_region["Nordeste"]["branca"])
    end
    within(id: "parda-regiao-nordeste") do
      assert_text number_with_delimiter(racial_diversity_grouped_by_region["Nordeste"]["parda"])
    end
    within(id: "preta-regiao-nordeste") do
      assert_text number_with_delimiter(racial_diversity_grouped_by_region["Nordeste"]["preta"])
    end
    within(id: "amarela-regiao-nordeste") do
      assert_text number_with_delimiter(racial_diversity_grouped_by_region["Nordeste"]["amarela"])
    end
    within(id: "indigena-regiao-nordeste") do
      assert_text number_with_delimiter(racial_diversity_grouped_by_region["Nordeste"]["indigena"])
    end

    within(id: "nao-declarado-regiao-sudeste") do
      assert_text number_with_delimiter(racial_diversity_grouped_by_region["Sudeste"]["nao_declarado"])
    end
    within(id: "branca-regiao-sudeste") do
      assert_text number_with_delimiter(racial_diversity_grouped_by_region["Sudeste"]["branca"])
    end
    within(id: "parda-regiao-sudeste") do
      assert_text number_with_delimiter(racial_diversity_grouped_by_region["Sudeste"]["parda"])
    end
    within(id: "preta-regiao-sudeste") do
      assert_text number_with_delimiter(racial_diversity_grouped_by_region["Sudeste"]["preta"])
    end
    within(id: "amarela-regiao-sudeste") do
      assert_text number_with_delimiter(racial_diversity_grouped_by_region["Sudeste"]["amarela"])
    end
    within(id: "indigena-regiao-sudeste") do
      assert_text number_with_delimiter(racial_diversity_grouped_by_region["Sudeste"]["indigena"])
    end

    within(id: "nao-declarado-regiao-sul") do
      assert_text number_with_delimiter(racial_diversity_grouped_by_region["Sul"]["nao_declarado"])
    end
    within(id: "branca-regiao-sul") do
      assert_text number_with_delimiter(racial_diversity_grouped_by_region["Sul"]["branca"])
    end
    within(id: "parda-regiao-sul") do
      assert_text number_with_delimiter(racial_diversity_grouped_by_region["Sul"]["parda"])
    end
    within(id: "preta-regiao-sul") do
      assert_text number_with_delimiter(racial_diversity_grouped_by_region["Sul"]["preta"])
    end
    within(id: "amarela-regiao-sul") do
      assert_text number_with_delimiter(racial_diversity_grouped_by_region["Sul"]["amarela"])
    end
    within(id: "indigena-regiao-sul") do
      assert_text number_with_delimiter(racial_diversity_grouped_by_region["Sul"]["indigena"])
    end

    within(id: "nao-declarado-regiao-centro-oeste") do
      assert_text number_with_delimiter(racial_diversity_grouped_by_region["Centro-Oeste"]["nao_declarado"])
    end
    within(id: "branca-regiao-centro-oeste") do
      assert_text number_with_delimiter(racial_diversity_grouped_by_region["Centro-Oeste"]["branca"])
    end
    within(id: "parda-regiao-centro-oeste") do
      assert_text number_with_delimiter(racial_diversity_grouped_by_region["Centro-Oeste"]["parda"])
    end
    within(id: "preta-regiao-centro-oeste") do
      assert_text number_with_delimiter(racial_diversity_grouped_by_region["Centro-Oeste"]["preta"])
    end
    within(id: "amarela-regiao-centro-oeste") do
      assert_text number_with_delimiter(racial_diversity_grouped_by_region["Centro-Oeste"]["amarela"])
    end
    within(id: "indigena-regiao-centro-oeste") do
      assert_text number_with_delimiter(racial_diversity_grouped_by_region["Centro-Oeste"]["indigena"])
    end

    within(id: "nao-declarado-regiao-norte") do
        assert_text number_with_delimiter(racial_diversity_grouped_by_region["Norte"]["nao_declarado"])
    end
    within(id: "branca-regiao-norte") do
      assert_text number_with_delimiter(racial_diversity_grouped_by_region["Norte"]["branca"])
    end
    within(id: "parda-regiao-norte") do
      assert_text number_with_delimiter(racial_diversity_grouped_by_region["Norte"]["parda"])
    end
    within(id: "preta-regiao-norte") do
      assert_text number_with_delimiter(racial_diversity_grouped_by_region["Norte"]["preta"])
    end
    within(id: "amarela-regiao-norte") do
      assert_text number_with_delimiter(racial_diversity_grouped_by_region["Norte"]["amarela"])
    end
    within(id: "indigena-regiao-norte") do
      assert_text number_with_delimiter(racial_diversity_grouped_by_region["Norte"]["indigena"])
    end


  end
end
