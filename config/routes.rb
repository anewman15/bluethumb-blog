Rails.application.routes.draw do
  resources :posts, except: [:update, :destroy, :edit] do
    resources :comments, except: [:update, :destroy, :edit]
  end

  root to: 'posts#index'
end
