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

	resources :disks, concerns: :alertable do
		member do
			resources :disk_statuses
		end
	end

	resources :alerts
	resources :extended_attributes
	resources :disk_statuses, only: :create

end