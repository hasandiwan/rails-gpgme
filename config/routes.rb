Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'sign', to: 'application#index'
  post 'verify', to: 'application#verify'
end
