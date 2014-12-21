Rails.application.routes.draw do

	concern :alertable do
		resources :alerts
	end

	resources :machines, concerns: :alertable

	resources :disks, concerns: :alertable do
		member do
			resources :disk_statuses
		end
	end

	resources :alerts

end