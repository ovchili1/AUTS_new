Rails.application.routes.draw do
  post 'refresh', controller: :refresh, action: :create
  post 'signup', controller: :signup, action: :create
  post 'signin', controller: :signin, action: :create
  delete 'signin', controller: :signin, action: :destroy


  resources :users, except: [:create, :index]

  namespace :admin do
    resources :users, except: [:create]
  end

  namespace :teacher do
    resources :themas
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
