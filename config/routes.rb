Rails.application.routes.draw do
  # get 'templates', to: 'home#templates'
  # patch 'thank-you-template/update', to: 'thank_you_templates#update'
  # get 'thank-you-template/edit', to: 'thank_you_templates#edit'
  resources :templates
  root :to => 'home#show'
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
