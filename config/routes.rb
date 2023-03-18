Rails.application.routes.draw do
  resources :racial_diversity_by_year, only: :show, param: :year
  get 'racial_diversity/index'
  get 'racial_diversity_by_region/:region', to: 'racial_diversity_by_region#show', as: :racial_diversity_by_region
  get 'brazil/show'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "racial_diversity#index"
end
