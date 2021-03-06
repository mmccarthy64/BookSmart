Rails.application.routes.draw do
  root to: "static#home"

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users do
    resources :books, only: [:new, :create, :index]
  end
  resources :comments
  
  get '/books/with_comments', :controller => 'books', :action => 'with_comments'

  resources :books do
    resources :comments, only: [:new, :create, :index]
  end

  get '/search' => 'books#search', :as => 'search_page'
  
end
