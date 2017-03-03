Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'posts#index'

  resources :posts, shallow: true do
    resources :comments, only: [:create, :destroy]
  end

  resources :users, only: [:new, :create, :edit, :update] do
    put :password 
  end

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end
end
