Rails.application.routes.draw do
  get 'racial_diversity/index'
  get 'racial_diversity_by_region/:region', to: 'racial_diversity_by_region#show', as: :racial_diversity_by_region
  get 'brazil/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
