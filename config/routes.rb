Rails.application.routes.draw do
 
  devise_for :users
  resources :events do	
  	collection do
      get :latest
      post :bulk_update
    end

    member do
    	get :dashboard
    	post :public
    	post :unpublic
      post :toggle_public
    end

  	resources :attendees, controller: 'event_attendees'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'events#index'

  namespace :admin do
    resources :events
  end
end
