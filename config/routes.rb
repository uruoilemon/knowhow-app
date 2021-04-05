Rails.application.routes.draw do
  devise_for :users
  root to: "posts#index"
  resources :posts do
    resources :tags
   collection do
    get 'search'
    get 'tag_search'
   end
  end
end
