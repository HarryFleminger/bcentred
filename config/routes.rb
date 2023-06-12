Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'sessions',
    registrations: 'registrations'
  }
  resources :users, only: [:index] do
    member do
      put 'make_admin', to: 'owner#make_admin'
      put 'remove_admin', to: 'owner#remove_admin'
      delete 'destroy', to: 'owner#destroy', as: :destroy
    end
  end
  root 'pages#home'
  get '/our_offer', to: 'pages#our_offer', as: :our_offer
  resources :blog_posts
end
