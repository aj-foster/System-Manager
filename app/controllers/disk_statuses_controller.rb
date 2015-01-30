class DiskStatusesController < ApplicationController

	before_action :authenticate

	def create
		@disk = Disk.where(serial_number: status_params[:serial_number]).first
		

		if @disk.present?
			status_params.delete :serial_number
			@status = DiskStatus.new(status_params)
			@status.disk = @disk
		else
			Alert.touch(name: "Missing Drive", message: "A system is reporting status information for an unknown disk, with serial number #{status_params[:serial_number]}.")
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
			params.require(:disk_status).permit!
		end
end