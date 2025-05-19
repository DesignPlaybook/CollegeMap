Rails.application.routes.draw do
  post "payments/create_order"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resource :sessions, only: [:create, :destroy, :show] do
    post "send_verification_code"
  end

  namespace :api do
    namespace :v1 do
      resources :institutes, only: [:index] do
        collection do
          post :primary_result
          post :enhanced_result
          post :download_result
          post :check_eligibility
          post :import_institutes
          post :check_consistancy
          post :check_balance
        end
      end

      resources :payments, only: [] do
        collection do
          post :create_order
          post :verify
        end
      end
    end
  end
  
  
  # Defines the root path route ("/")
  # root "posts#index"
end
