Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      get '/current_status' => "current_status#index"
      post '/current_status' => "current_status#update"
    end
  end
  
  root 'current_status#index'
end
