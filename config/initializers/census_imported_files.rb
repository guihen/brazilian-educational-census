Rails.application.define_singleton_method(:path_to_census_2021) do
  Rails.root.join('lib', 'census_data', '2021.csv')
end
