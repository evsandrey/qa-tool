Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations',
        passwords: 'users/passwords',
        unlocks: 'users/unlocks',
        confirmations: 'users/confirmations',
        #omniauth_callbacks: 'users/omniauth_callbacks'




  }
  resources :examples
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
