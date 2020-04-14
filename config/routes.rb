Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

devise_for :users
# homesコントローラ
root 'homes#top'
get "home/about", to: "homes#about"
# booksコントローラ
resources :books
# userのコントローラ
resources :users

end

