class DisksController < ApplicationController

	before_filter :authenticate_user!

	def index
		@disks = Disk.includes(:alerts).order(name: :asc)
		@disks_with_alerts = []

		@disks.each do |disk|
			if disk.alerts.count > 0
				@disks_with_alerts << disk
			end
		end
	end

	def show
		@disk = Disk.find(params[:id])
	end

	def new
		@disk = Disk.new
	end

	def create
		@disk = Disk.new(disk_params)

		if @disk.save
			redirect_to @disk, notice: "The new disk, #{@disk.name}, has been saved."
		else
			render :new
		end
	end

	def edit
		@disk = Disk.find(params[:id])
	end

	def update
		@disk = Disk.find(params[:id])

		if @disk.update(disk_params)
			redirect_to @disk, notice: "Updated information about #{@disk.name}."
		else
			render :edit
		end
	end

	def destroy
		@disk = Disk.find(params[:id])

		if @disk.destroy
			redirect_to disks_path, notice: "#{@disk.name} has been removed."
		else
			redirect_to @disk, alert: "Error: Could not remove #{@disk.name}."
		end
	end


	private

		def disk_params
			params.require(:disk).permit!
		end
end