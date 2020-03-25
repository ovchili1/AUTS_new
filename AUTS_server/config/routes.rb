Rails.application.routes.draw do
  resources :testings
  resources :questions
  post 'refresh', controller: :refresh, action: :create
  post 'signup', controller: :signup, action: :create
  post 'signin', controller: :signin, action: :create
  delete 'signin', controller: :signin, action: :destroy
  get 'me', controller: :users, action: :me

  get 'all_teachers',controller: :users, action: :all_teachers

  get 'my_profile', controller: :users, action: :profile


  resources :users, except: [:create, :index]

  namespace :admin do
    resources :users, except: [:create]
    resources :themas, except: [:create]
    resources :tests, except: [:create]
    resources :questions, except: [:create]
    resources :testings, except: [:creates]
  end

  namespace :teacher do
    resources :themas
    resources :tests
    resources :questions
  end

  namespace :student do
    resources :testings, except: [:update, :destroy]
    resources :tests, only: [:show]
  end

  resources :themas, only: [:index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
