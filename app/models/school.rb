class School < ApplicationRecord
  def setor
    zipcode[0..2]
  end
end
