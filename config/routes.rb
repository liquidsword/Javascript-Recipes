Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root to: "home_page#home"
get "/signin", to: "sessions#new"
post "/signin", to: "sessions#create"
get '/auth/:provider/callback' => 'sessions#omnicreate'
get "/logout", to: "sessions#destroy"
get "/alpha/recipes", to: "recipes#alpha"

resources :culinary_artists do
  resources :recipes, only: [:show, :index, :new, :create, :edit, :destroy]
  resources :recipe_ingredients, only: [:index, :show]
end

resources :recipes, only: [:show, :index, :new, :create, :edit, :destroy]

#resources :recipe_ingredients

resources :ingredients

end
