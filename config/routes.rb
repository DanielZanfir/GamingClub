Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#home'
  get 'about', to: 'welcome#about'

  resources :articles

  get 'signup', to: 'users#new'
  resources :users, except: [:new]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'categories', to: 'categories#index'
  post 'categories', to: 'categories#create'

  get 'categories/new', to: 'categories#new', as: 'new_category'
  get 'categories/:id/edit', to: 'categories#edit', as: 'edit_category'
  get 'categories/:id', to: 'categories#show', as: 'category'
  patch 'categories/:id', to: 'categories#update'
  put 'categories/:id', to: 'categories#update'
 # resource :categories, except: [:destroy]


end
