Rails.application.routes.draw do
  devise_for :users
  root to: "posts#index"
  resources :posts, only:[:index,:new,:create] do
   collection do
    get 'search'
   end
  end
end
