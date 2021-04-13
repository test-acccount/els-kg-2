Rails.application.routes.draw do
  match "(*any)", to: redirect(subdomain: ""), via: :all, constraints: { subdomain: "www" }

  devise_for :users, only: :omniauth_callbacks, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  scope "(:locale)", locale: /en|ru/ do
    get "omniauth_localized_google_oauth2" => "omniauth_localized#google_oauth2"
    devise_for :users, skip: :omniauth_callbacks, controllers: { registrations: "users/registrations", omniauth_callbacks: "users/omniauth_callbacks" }

    resources :pages, param: :slug, only: :show
    resources :news, only: [:index, :show]

    resource :passport, only: [:new, :create]
    get "us_address", to: "us_address#show"

    resources :packages do
      collection do
        get "expected"
        get "warehouse"
        get "in_transit"
        get "arrived"
      end
      get "photos", on: :member
    end

    get "contacts" => "pages#contacts"
    get "stores" => "pages#stores"
    get "find_tracking" => "pages#find_tracking"
  end

  namespace :admin do
    root "packages#index"
    resources :users, only: :index

    resources :incoming_packages, only: [:index, :create, :destroy]
    resources :packages do
      get "new_or_edit", on: :collection
      get "cn23", on: :member
      delete "destroy_image", on: :member
    end

    resources :shipments do
      get "pending_invoice", on: :collection
      member do
        get "invoice"
        get "list_cp71"
        get "invoice_register"
        patch "set_as_in_transit"
        patch "set_as_arrived"
      end
    end

    resources :pages, except: :show
    resources :news, except: :show

    resource :site_pricing, only: [:edit, :update]
    resource :site_setting, only: [:edit, :update]
    resource :shipment_next_date, only: [:edit, :update]

    post "autocomplete_find_user", to: "autocomplete#find_user"
    post "autocomplete_suggestions", to: "autocomplete#suggestions"
  end

  get "/:locale" => "pages#index"
  root "pages#index"
end
