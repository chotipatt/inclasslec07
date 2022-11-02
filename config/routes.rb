Rails.application.routes.draw do
  get 'main/login'
  post 'main/create' ,to: 'main#create' , as: 'check'
  get 'main/destroy'
  resources :users
  resources :scores
  resources :students
  get 'students/:id/edit_score' , to: 'students#edit_score' , as: 'aaa'
  #get 'adfa' ,to: 'students#new', as: 'somchai'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
