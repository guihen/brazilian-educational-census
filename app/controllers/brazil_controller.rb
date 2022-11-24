class BrazilController < ApplicationController
  def show
    @total_schools = School.all.count
  end
end
