Rails.application.routes.draw do
  devise_for :users, path: '', controllers: { registrations: "registrations" }

  authenticated :user do
    root :to => 'users#show', :as => :authenticated_root
  end

  root :to => redirect('/users/sign_in')

  resources :users do
    resources :to_do_lists, shallow: true
  end
end
