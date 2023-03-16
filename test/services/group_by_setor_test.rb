require "test_helper"

class GroupBySetorTest < ActiveSupport::TestCase
  test "should return a list of SetorGroup" do
    school = schools(:acre_2021)
    subject = GroupBySetor.new([school])

    result = subject.call

    assert_instance_of Array, result
    assert_instance_of SetorGroup, result.first
  end

  test "should receive a list of schools to be grouped" do
    assert_nothing_raised do
      GroupBySetor.new(School.all)
    end
  end

  test "should return a SetorGroup for each school with different setor" do
    same_setor = schools(:sao_paulo_albino_cesar_2021, :sao_paulo_philomena_baylao_profa_2021)
    different_setor = schools(:bahia_2021)
    input = same_setor + [different_setor]
    subject = GroupBySetor.new(input)

    result = subject.call

    assert_equal 2, result.size
  end

  test "should return the racial diversity related to each setor" do
    same_setor = schools(:sao_paulo_albino_cesar_2021, :sao_paulo_philomena_baylao_profa_2021)
    different_setor = schools(:bahia_2021)
    input = same_setor + [different_setor]
    subject = GroupBySetor.new(input)
    expected_racial_diversity_1 = {
      "nao_declarado" => 370 + 256,
      "branca" => 780 + 525,
      "parda" => 268 + 281,
      "preta" => 24 + 12,
      "amarela" => 10 + 7,
      "indigena" => 4 + 1
    }

    expected_racial_diversity_2 =     {
          "nao_declarado" => 0,
          "branca" => 0,
          "preta" => 0,
          "parda" => 0,
          "amarela" => 0,
          "indigena" => 0
        }

    result = subject.call
    setor_group_1 = result.detect { |setor_group| setor_group.setor == "023" }
    setor_group_2 = result.detect { |setor_group| setor_group.setor == "456" }

    assert_equal expected_racial_diversity_1, setor_group_1.racial_diversity
    assert_equal expected_racial_diversity_2, setor_group_2.racial_diversity
  end
end
