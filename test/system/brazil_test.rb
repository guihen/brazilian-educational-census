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

  test "should have the racial diversity accumulated for the entire country" do
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

    visit brazil_show_url

    assert_text "Total de Não Declarados: #{racial_diversity_totals["nao_declarado"]}"
    assert_text "Total de Brancas: #{racial_diversity_totals["branca"]}"
    assert_text "Total de Pardas: #{racial_diversity_totals["parda"]}"
    assert_text "Total de Pretas: #{racial_diversity_totals["preta"]}"
    assert_text "Total de Amarelas: #{racial_diversity_totals["amarela"]}"
    assert_text "Total de Indígenas: #{racial_diversity_totals["indigena"]}"
  end
end
