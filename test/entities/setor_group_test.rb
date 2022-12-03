require "test_helper"

class SetorGroupTest < ActiveSupport::TestCase
  test "should return the setor" do
    expected_setor = 021

    subject = SetorGroup.new
    subject.setor = expected_setor

    assert_equal expected_setor, subject.setor
  end

  test "should return the county" do
    expected_county = "São Paulo"

    subject = SetorGroup.new
    subject.county = expected_county

    assert_equal expected_county, subject.county
  end

  test "should return the racial_diversity" do
    expected_racial_diversity = {
      "nao_declarado": 3,
      "branca": 10,
      "parda": 12,
      "preta": 7,
      "amarela": 2,
      "indigena": 4
    }

    subject = SetorGroup.new
    subject.racial_diversity = expected_racial_diversity

    assert_equal expected_racial_diversity, subject.racial_diversity
  end
end
