class DrivesController < ApplicationController

	before_filter :authenticate_user!

	def index
		@drives = Drive.includes(:alerts).order(name: :asc)
		@drives_with_alerts = []

		@drives.each do |drive|
			if drive.alerts.count > 0
				@drives_with_alerts << drive
			end
		end
	end

	def show
		@drive = Drive.find(params[:id])
	end

	def new
		@drive = Drive.new
	end

	def create
		@drive = Drive.new(drive_params)

		if @drive.save
			redirect_to @drive, notice: "The new drive, #{@drive.name}, has been saved."
		else
			render :new
		end
	end

	def edit
		@drive = Drive.find(params[:id])
	end

	def update
		@drive = Drive.find(params[:id])

		if @drive.update(drive_params)
			redirect_to @drive, notice: "Updated information about #{@drive.name}."
		else
			render :edit
		end
	end

	def destroy
		@drive = Drive.find(params[:id])

		if @drive.destroy
			redirect_to drives_path, notice: "#{@drive.name} has been removed."
		else
			redirect_to @drive, alert: "Error: Could not remove #{@drive.name}."
		end
	end


	private

		def drive_params
			params.require(:drive).permit!
		end
end