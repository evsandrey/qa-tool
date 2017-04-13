Rails.application.routes.draw do
  
  resources :categories
  resources :hosts
  resources :reports do
    member do
      get 'show_direct'
    end
  end
  get '/investigation_form', to: "reports#investigation_form"
  post '/investigation_update', to: "reports#investigation_update"
  
  resources :investigation_results
  resources :bugs
  resources :bulids
  resources :versions
  resources :products do
    member do
        post '/report', to: "reports#report_end"
        get '/report', to: "reports#report_end"
    end
    resources :versions do
      member do
        post '/report', to: "reports#report_end"
      end
      resources :builds
      resources :hosts
      resources :categories
      resources :test_cases do 
        resources :reports
      end
    end
  end
  resources :logs
  
  
  root to: "products#index"
  
  get 'static/index'
  get 'static/faq'
  get 'static/reports'
  get 'static/profiles'
  
  resources :global_messages
  get 'global_chat' => 'global_messages#global_chat', as: 'global_chat_log'
  
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations',
        passwords: 'users/passwords',
        unlocks: 'users/unlocks',
        confirmations: 'users/confirmations',
        #omniauth_callbacks: 'users/omniauth_callbacks'
  }
  
  devise_scope :user do
    get 'profile/:id' => 'users/registrations#show', as: 'profile'
    get 'profile/:id/admin_edit' => 'users/registrations#admin_edit_profile', as: 'edit_profile'
    post 'profile/:id/admin_update' => 'users/registrations#admin_update_profile', as: 'update_profile'
  end
  
  
  
  
  resources :examples
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  mount ActionCable.server => '/cable'
  get '/init_chat', to: "global_messages#init_chat"
  
end
