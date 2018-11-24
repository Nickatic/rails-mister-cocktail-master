Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :cocktails, only: [:index, :show, :new, :create] do
    resources :doses, only: [:new, :create]
  end
  resources :doses, only: :destroy
  post "search/results", to: "cocktails#search"
  get "search/results", to: "cocktails#search"
  root to: "cocktails#index"
end
