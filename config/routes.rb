Rails.application.routes.draw do
  
  resources :logs
  root to: "static#index"
  
  get 'static/index'

  get 'static/faq'

  get 'static/reports'

 
  
  resources :global_messages
  
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
  
  mount ActionCable.server => '/cable'
  get '/init_chat', to: "global_messages#init_chat"
  
end
