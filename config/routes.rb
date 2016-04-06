Rails.application.routes.draw do
  post '/' => 'status#update'  
  root 'status#index'
end
