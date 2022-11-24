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
end
