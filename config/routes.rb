Rails.application.routes.draw do
  devise_for :users
  resources :films do
    post 'rate'
  end
end
