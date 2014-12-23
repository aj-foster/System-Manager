class AlertsController < ApplicationController

	def index
		@alerts = Alert.order(updated_at: :desc)
	end

	def show
		@alert = Alert.find(params[:id])
	end

	def destroy
		@alert = Alert.find(params[:id])

		if @alert.destroy
			redirect_to alerts_path, notice: "The alert, #{@alert.name}, has been removed."
		else
			redirect_to @alert, alert: "Error: Could not remove the alert."
		end
	end
end