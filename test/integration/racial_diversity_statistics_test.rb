require "test_helper"
require "rake"

class RacialDiversityCalculationsTaskTest < ActiveSupport::TestCase
  test "should generate calculated values for Brazil in 2022" do
    Rails.application.load_tasks if Rake::Task.tasks.empty?

    assert_difference 'CalculatedRacialDiversity.count', 1 do
      Rake::Task["racial_diversity:totals_for_2022"].invoke
    end

    # Assertions
    CalculatedRacialDiversity.find_by_slug('totals_2022').tap do |record|
      assert_equal %w(parda preta branca amarela indigena nao_declarado), record.value.keys
    end
  end

  test "should generate calculated values for Brazil in 2021" do
    Rails.application.load_tasks if Rake::Task.tasks.empty?

    assert_difference 'CalculatedRacialDiversity.count', 1 do
      Rake::Task["racial_diversity:totals_for_2021"].invoke
    end

    # Assertions
    CalculatedRacialDiversity.find_by_slug('totals_2021').tap do |record|
      assert_equal %w(parda preta branca amarela indigena nao_declarado), record.value.keys
    end
  end
end