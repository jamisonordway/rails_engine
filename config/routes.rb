Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end

      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end

      namespace :transactions do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end

      resources :merchants, except: [:new, :edit]
      resources :transactions, except: [:new, :edit]
      resources :invoices, except: [:new, :edit]
      resources :items, except: [:new, :edit]
      resources :invoice_items, except: [:new, :edit]

    end
  end
end
