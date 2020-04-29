Rails.application.routes.draw do
  resources :shows, only: %i[create destroy index]

  mount Raddocs::App => "/docs"

  match '*unmatched', to: 'application#not_found', via: :all
end
