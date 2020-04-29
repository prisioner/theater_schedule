Rails.application.routes.draw do
  resources :shows, only: %i[create destroy index]

  match '*unmatched', to: 'application#not_found', via: :all
end
