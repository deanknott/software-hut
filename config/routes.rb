Rails.application.routes.draw do

  devise_for :users, controllers: {registrations: 'users/registrations', sessions: 'users/sessions',  passwords: 'users/passwords'}

  # New routes for devise logging in and registering
  devise_scope :user do
    get :login, to: 'devise/sessions#new', as: 'login'
    post :login, to: 'devise/sessions#create'
    get :register, to: 'users/registrations#new', as: 'registration'
    post :register, to: 'users/registrations#create'
    get :forgotten_password, to: 'users/passwords#new', as: 'forgotten_password'
    post :forgotten_password, to: 'users/passwords#edit'
    get :change_password, to: 'users/registrations#edit', as: 'change_password'
    # post :change_password, to: 'users/registrations#update'
  end

  resources :roles
  resources :institutions
  resources :account_privacies
  resources :departments
  resources :costs
  resources :student_types
  resources :incoming_qualifications
  resources :eligibility_requirements
  resources :end_qualifications
  resources :deliver_modes
  resources :wps
  resources :stored_searches
  resources :courses do
    post :search, on: :collection
  end
  resources :members do
    post :search, on: :collection
  end
  resources :static_pages, except: [:index, :destroy], param: :name, path: 'about' do
     get :show_file, on: :member
     get :download_file, on: :member
  end

  resources :uploads, only: [:new] do
    post :upload_courses, on: :collection
  end
  resources :blogs do
    get :show_file, on: :member
    get :download_file, on: :member
  end

  resource :passwords, only: [:new, :create, :edit, :update] do
    member do
    put :reset
    end
  end


  match '/403', to: 'errors#error_403', via: :all
  match '/404', to: 'errors#error_404', via: :all
  match '/422', to: 'errors#error_422', via: :all
  match '/500', to: 'errors#error_500', via: :all

  get :ie_warning, to: 'errors#ie_warning'
  get :javascript_warning, to: 'errors#javascript_warning'

  # Add routes for all pages

  get :degree_search, to: 'pages#degree_search', as: 'degree_search'
  get :'degree_search/advanced', to: 'pages#advanced_search', as: 'advanced_search'

  # static pages
  post :'update-static-page', to: 'static_pages#update_static_page', as: 'update_static_page'
  get :'about', to: 'static_pages#about', as: 'about'

  post :'sending', to: 'messages#create', as: 'send_message'
  get :'members/*id/contact', to: 'members#contact', as: 'contact_member'

  get :'members/*id/validate', to: 'members#validate_member', as: 'validate_member'
  post :'members/*id/validate', to: 'members#validate_send'


  root to: 'static_pages#home'

  #stored searches
  get :'create-search', to: 'stored_searches#create_search', as:'create-search'
  get :'save-search', to: 'stored_searches#save_search', as:'save-search'
  get :'delete-search', to: 'stored_searches#delete_search', as:'delete-search'

  get :'scrape', to: 'courses#scrape', as:'scrape-courses'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
