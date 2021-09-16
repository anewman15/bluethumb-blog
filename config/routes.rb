Rails.application.routes.draw do
  resources :posts, except: [:update, :destroy, :edit] do
    resources :comments, only: [:create]
  end

  root to: 'pages#home'
end
