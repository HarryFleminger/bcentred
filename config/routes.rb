Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'pages#home'
  get '/our_offer', to: 'pages#our_offer', as: :our_offer
  resources :blog_posts
  resources :users
end
