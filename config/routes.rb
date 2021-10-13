Rails.application.routes.draw do
  resources :posts
  resources :users

  get 'main' ,to: 'users#main'
  post 'main', to: 'users#login'
  get 'feed', to: 'users#feed'
  get 'register', to:'users#register'
  get '/profile/:name', to: 'users#profile'
  post '/profile/:name/follow', to: 'users#follow' ,as: "follow_user"
  post '/profile/:name/unfollow', to: 'users#unfollow' ,as: "unfollow_user"

  get 'new_post', to:'posts#new_post'
  post 'createPost', to: 'posts#createPost'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
