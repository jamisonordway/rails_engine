Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end

      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'searcg#index'
      end

      resources :merchants, except: [:new, :edit]
      resources :invoices, except: [:new, :edit]
      resources :items, except: [:new, :edit]
      resources :invoice_items, except: [:new, :edit]

    end
  end
end
