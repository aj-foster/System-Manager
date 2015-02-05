class DriveStatusesController < ApplicationController

	before_action :authenticate

	def create
		@drive = Drive.where(serial_number: status_params[:serial_number]).first
		

		if @drive.present?
			status_params.delete :serial_number
			@status = DriveStatus.new(status_params)
			@status.drive = @drive
		else
			Alert.touch(name: "Missing Drive", message: "A system is reporting status information for an unknown drive, with serial number #{status_params[:serial_number]}.")
			return render text: "Unknown Drive", status: 422
		end

		if @status.save
			render text: "Success"
		else
			render text: "Failure", status: 400
		end
	end


	private

		def authenticate
			authenticate_or_request_with_http_token do |token|
				token == Rails.application.secrets.auth_token
			end
		end

		def status_params
			params.require(:drive_status).permit!
		end
end