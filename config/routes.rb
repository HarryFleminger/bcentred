Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'sessions',
    registrations: 'registrations'
  }
  root 'pages#home'
  get '/our_offer', to: 'pages#our_offer', as: :our_offer
  resources :blog_posts
  resources :users
end
