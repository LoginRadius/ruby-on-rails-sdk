Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

 root :to => 'application#index'
  post "callback" =>"application#callback"
  get "callback" => redirect("/")
  get "logout" => 'application#logout'
  get "profile" => 'application#profile'
  post "profile" => 'application#callback'
  post "ajax" => 'ajax#ajax'
  
end
