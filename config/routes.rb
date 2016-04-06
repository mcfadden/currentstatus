Rails.application.routes.draw do
  
  # Rails really doesn't like having a format (ex, JSON) on the root route
  # so I've added a duplicate /status route to make the JSON API simpler.
  get '/status' => "status#index"
  post '/status' => "status#update"
  
  post '/' => 'status#update'  
  root 'status#index'
end
