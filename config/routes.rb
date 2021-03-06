Rails.application.routes.draw do

  root 'static_pages#root'

  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :edit, :update] do
    resources :stocks, only: :index
  end
  
  get 'stocks/symbol/:ticker_symbol' => 'stocks#show'
  resources :stocks, only: [:show, :create] do
    resources :transactions, only: [:new, :create]
  end

end
