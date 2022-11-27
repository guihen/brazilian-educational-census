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

  test "should have racial diversity grouped by region" do
    structure_to_be_processed = {
      "Norte" => Hash.new(0),
      "Nordeste" => Hash.new(0),
      "Centro-Oeste" => Hash.new(0),
      "Sudeste" => Hash.new(0),
      "Sul" => Hash.new(0)
    }
    racial_diversity_grouped = School.pluck(:region, :racial_diversity).reduce(structure_to_be_processed) do |memo, school|
      if school[1].present?
        memo[school[0]].tap do |region_accumulator|
          region_accumulator["nao_declarado"] = region_accumulator["nao_declarado"] + school[1]["nao_declarado"]
          region_accumulator["branca"] = region_accumulator["branca"] + school[1]["branca"]
          region_accumulator["parda"] = region_accumulator["parda"] + school[1]["parda"]
          region_accumulator["preta"] = region_accumulator["preta"] + school[1]["preta"]
          region_accumulator["amarela"] = region_accumulator["amarela"] + school[1]["amarela"]
          region_accumulator["indigena"] = region_accumulator["indigena"] + school[1]["indigena"]
        end
      end

      memo
    end

    visit brazil_show_url

    assert_text "Total de Não Declarados (Região Norte): #{racial_diversity_grouped["Norte"]["nao_declarado"]}"
    assert_text "Total de Brancas (Região Norte): #{racial_diversity_grouped["Norte"]["branca"]}"
    assert_text "Total de Pardas (Região Norte): #{racial_diversity_grouped["Norte"]["parda"]}"
    assert_text "Total de Pretas (Região Norte): #{racial_diversity_grouped["Norte"]["preta"]}"
    assert_text "Total de Amarelas (Região Norte): #{racial_diversity_grouped["Norte"]["amarela"]}"
    assert_text "Total de Indígenas (Região Norte): #{racial_diversity_grouped["Norte"]["indigena"]}"
    assert_text "Total de Não Declarados (Região Nordeste): #{racial_diversity_grouped["Nordeste"]["nao_declarado"]}"
    assert_text "Total de Brancas (Região Nordeste): #{racial_diversity_grouped["Nordeste"]["branca"]}"
    assert_text "Total de Pardas (Região Nordeste): #{racial_diversity_grouped["Nordeste"]["parda"]}"
    assert_text "Total de Pretas (Região Nordeste): #{racial_diversity_grouped["Nordeste"]["preta"]}"
    assert_text "Total de Amarelas (Região Nordeste): #{racial_diversity_grouped["Nordeste"]["amarela"]}"
    assert_text "Total de Indígenas (Região Nordeste): #{racial_diversity_grouped["Nordeste"]["indigena"]}"
    assert_text "Total de Não Declarados (Região Centro-Oeste): #{racial_diversity_grouped["Centro-Oeste"]["nao_declarado"]}"
    assert_text "Total de Brancas (Região Centro-Oeste): #{racial_diversity_grouped["Centro-Oeste"]["branca"]}"
    assert_text "Total de Pardas (Região Centro-Oeste): #{racial_diversity_grouped["Centro-Oeste"]["parda"]}"
    assert_text "Total de Pretas (Região Centro-Oeste): #{racial_diversity_grouped["Centro-Oeste"]["preta"]}"
    assert_text "Total de Amarelas (Região Centro-Oeste): #{racial_diversity_grouped["Centro-Oeste"]["amarela"]}"
    assert_text "Total de Indígenas (Região Centro-Oeste): #{racial_diversity_grouped["Centro-Oeste"]["indigena"]}"
    assert_text "Total de Não Declarados (Região Sudeste): #{racial_diversity_grouped["Sudeste"]["nao_declarado"]}"
    assert_text "Total de Brancas (Região Sudeste): #{racial_diversity_grouped["Sudeste"]["branca"]}"
    assert_text "Total de Pardas (Região Sudeste): #{racial_diversity_grouped["Sudeste"]["parda"]}"
    assert_text "Total de Pretas (Região Sudeste): #{racial_diversity_grouped["Sudeste"]["preta"]}"
    assert_text "Total de Amarelas (Região Sudeste): #{racial_diversity_grouped["Sudeste"]["amarela"]}"
    assert_text "Total de Indígenas (Região Sudeste): #{racial_diversity_grouped["Sudeste"]["indigena"]}"
    assert_text "Total de Não Declarados (Região Sul): #{racial_diversity_grouped["Sul"]["nao_declarado"]}"
    assert_text "Total de Brancas (Região Sul): #{racial_diversity_grouped["Sul"]["branca"]}"
    assert_text "Total de Pardas (Região Sul): #{racial_diversity_grouped["Sul"]["parda"]}"
    assert_text "Total de Pretas (Região Sul): #{racial_diversity_grouped["Sul"]["preta"]}"
    assert_text "Total de Amarelas (Região Sul): #{racial_diversity_grouped["Sul"]["amarela"]}"
    assert_text "Total de Indígenas (Região Sul): #{racial_diversity_grouped["Sul"]["indigena"]}"
  end
end
