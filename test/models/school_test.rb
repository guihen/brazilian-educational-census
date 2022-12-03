require "test_helper"

class SchoolTest < ActiveSupport::TestCase
  test "returns setor" do
    subject = School.new(zipcode: 86460000)

    assert_equal "864", subject.setor
  end
end
