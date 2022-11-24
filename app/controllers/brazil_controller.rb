class BrazilController < ApplicationController
  def show
    @total_schools = School.all.count
    @total_schools_by_region = School.group(:region).count
  end
end
