Rails.application.routes.draw do
  # root "newspapers#index" 
  root "articles#show"
  get 'crawl', action: :crawl, controller: 'newspapers'
  resources :newspapers do

    resources :articles
  end
  # get 'newspapers/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
