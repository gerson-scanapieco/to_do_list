Rails.application.routes.draw do
  devise_for :users, path: '', controllers: { registrations: "registrations" }

  authenticated :user do
    root :to => 'users#show', :as => :authenticated_root
  end

  root :to => redirect('/users/sign_in')

  resources :users do
    resources :to_do_lists, shallow: true do
      member do
        get :assignment_form
      end
    end
  end

  get "/public_to_do_lists", to: "to_do_lists#public"

  resources :favorite_to_do_lists, only: [:create, :destroy]
end
