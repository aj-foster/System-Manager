Rails.application.routes.draw do

	# Devise Configuration
	devise_for :users

	# App Root Configuration
	authenticated :user do
		root :to => 'alerts#index', :as => :authenticated_root
	end
	root :to => redirect('/users/sign_in')

	concern :alertable do
		resources :alerts
	end

	resources :machines, concerns: :alertable do
		collection do
			get :manage_ex_attrs
		end
	end

	resources :drives, concerns: :alertable do
		member do
			resources :drive_statuses
		end
	end

	resources :users, only: [:index, :show, :update, :destroy] do
		member do
			put :approve
		end
	end
	
	resources :alerts
	resources :extended_attributes
	resources :drive_statuses, only: :create

end