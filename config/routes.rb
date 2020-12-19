Rails.application.routes.draw do
  root 'static_pages#home'
  resources :rooms, :only => [:show, :create] do
    resources :messages, :only => [:create]
  end
  
  devise_for :companies, controllers: {
  sessions:      'companies/sessions',
  passwords:     'companies/passwords',
  registrations: 'companies/registrations'
}
  devise_for :users, controllers: {
  sessions:      'users/sessions',
  passwords:     'users/passwords',
  registrations: 'users/registrations'
}

  resources :users, only: [:index, :show]
  resources :companies, only: [:index, :show]
  post 'company/follow/:id' => 'relationships#follow', as: 'company_follow'
  post 'company/unfollow/:id' => 'relationships#unfollow', as: 'company_unfollow'
  post 'user/follow/:id' => 'associates#follow', as: 'user_follow'
  post 'user/unfollow/:id' => 'associates#unfollow', as: 'user_unfollow'

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :companies do
    member do
      get :following, :followers
    end
  end
end
