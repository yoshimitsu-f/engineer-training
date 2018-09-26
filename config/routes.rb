Rails.application.routes.draw do

  devise_for :users
  resources :posts do
    resources :comments
  end

  get '/' => 'home#top'
  get 'threads/index' => 'threads#index'
  get 'threads/new'   => 'threads#new'
  get 'threads/:id' => 'threads#show'
  post 'threads/create' => 'threads#create'
  get 'threads/:id/edit' => 'threads#edit'
  post 'threads/:id/update' => 'threads#update'
  post 'threads/:id/destroy' => 'threads#destroy'



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
