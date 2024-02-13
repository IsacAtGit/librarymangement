Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  post "user/create", to:"user#create"
  get "user/index", to:"user#index"
  get "user/show/:id", to:"user#show"
  put "user/edit/:id", to:"user#edit"
  delete "user/delete/:id", to:"user#delete"

  post "author/create", to:"author#create"
  get "author/index", to:"author#index"
  get "author/show/:id", to:"author#show"
  put "author/edit/:id", to:"author#edit"
  delete "author/delete/:id", to:"author#delete"


  post "book/create", to:"book#create"
  get "book/index", to:"book#index"
  get "book/show/:id", to:"book#show"
  put "book/edit/:id", to:"book#edit"
  delete "book/delete/:id", to:"book#delete"

  post "order/create",to:"order#create"
  put "order/:id/return",to:"order#update"
  get "order/readall", to:"order#show"

  patch "/makeusertoadmin/:id", to:"user#makeusertoadmin"
  get "user/login" ,to:"session#login"
  get "user/logout" ,to:"session#logout"
end
