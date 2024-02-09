Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  post "/createuser", to:"user#createuser"
  get "/readalluser", to:"user#readalluser"
  get "/readuser/:id", to:"user#readuser"
  put "/edituser/:id", to:"user#edituser"
  delete "/deleteuser/:id", to:"user#deleteuser"

  post "/createauthor", to:"author#createauthor"
  get "/readallauthor", to:"author#readallauthor"
  get "/readauthor/:id", to:"author#readauthor"
  put "/editauthor/:id", to:"author#editauthor"
  delete "/deleteauthor/:id", to:"author#deleteauthor"


  post "/createbook", to:"book#createbook"
  get "/readallbook", to:"book#readallbook"
  get "/readbook/:id", to:"book#readbook"
  put "/editbook/:id", to:"book#editbook"
  delete "/deletebook/:id", to:"book#deletebook"

  post "book/createorder",to:"order#createorder"
  put "book/:id/returnbook",to:"order#returnbook"
  get "book/userorders", to:"order#userorders"

  patch "/makeusertoadmin/:id", to:"user#makeusertoadmin"
  get "/login" ,to:"user#login"
end
