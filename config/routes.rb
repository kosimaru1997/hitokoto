Rails.application.routes.draw do
  root 'hitokoto#new'
  resources :hitokoto, only: [:create, :destoroy, :index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
