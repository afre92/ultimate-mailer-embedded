# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#index'
  
  scope '/embedded' do

    resource :settings, only: [:edit, :update, :index]
    resources :emails, only: [:index, :show]
    resources :reviews, only: [:index, :show]

    resources :templates do 
      get 'preview', to: 'templates#preview'
    end

    get 'charges/:subscription_type/create', to: 'charges#create', as: 'charge_create'
    get 'charges/:local_charge_id/activate', to: 'charges#activate', as: 'charge_activate'
    get 'charges/:local_charge_id/create_local_charge_only', to: 'charges#create_local_charge_only', as: 'charge_create_local_only'

    get 'onboarding', to: 'home#onboarding'
    get 'complete-onboarding', to: 'home#complete_onboarding'

    get 'pricing', to: 'settings#pricing'
    
    # get '/preview-template/:template_type', to: 'templates#preview', as: 'preview_template'
    # get '/convert/:token', to: 'analytics#convert' -d
    # root to: 'home#index'
    # get '/activatecharge', to: 'settings#activate_charge'
    # get 'create-charge/:id', to: 'settings#create_recurring_application_charge', as: 'create_charge'
    # get 'cancel-charge', to: 'settings#cancel_charge', as: 'cancel_charge'
    # get '/reviews', to: 'reviews#index', as: 'reviews' -d
    # get '/review/:id', to: 'reviews#show', as: 'review' -d
    # get '/review_update/:id', to: 'reviews#update', as: 'review_update'
  
    # get '/emails', to: 'emails#index', as: 'emails' -d
    # get '/email/:id', to: 'emails#show', as: 'email' -d
  
    # get '/complete-onboarding', to: 'settings#complete_onboarding', as: 'complete_onboarding'
    # get '/onboarding', to: 'home#onboarding', as: 'onboarding'
    get 'dashboard', to: 'home#index'
  end

  scope '/external' do
    get '/convert/:token', to: 'analytics#convert'
    
    resource :reviews, only: [:update]


  end



  # OLD

  mount ShopifyApp::Engine, at: '/embedded'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
