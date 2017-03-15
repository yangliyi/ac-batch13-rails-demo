Rails.application.routes.draw do
 
  resources :events do	
  	collection do
      get :latest
      post :bulk_delete
    end
  	resources :attendees, controller: 'event_attendees'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'events#index'
end
