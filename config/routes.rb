Rails.application.routes.draw do
  devise_for :users, path: '', controllers: { registrations: "registrations" }

  devise_scope :user do
    root to: "devise/sessions#new"
  end

  resources :users
end
