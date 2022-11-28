require "test_helper"

class SumRacialDiversityTest < ActiveSupport::TestCase
  test "should return the sum the list of racial diversity" do
    racial_diversities = schools(:rondonia, :acre, :pernambuco).map(&:racial_diversity)

    expected_result = {
      "nao_declarado" => 148,
      "branca" => 121,
      "preta" => 8,
      "parda" => 636,
      "amarela" => 1,
      "indigena" => 10
    }

    sum = SumRacialDiversity.new(racial_diversities).call

    assert_equal expected_result, sum
  end
end
