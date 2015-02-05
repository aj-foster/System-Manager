class MachinesController < ApplicationController

	before_filter :authenticate_user!

	def index
		@machines = Machine.includes(:alerts).order(name: :asc)
		@machines_with_alerts = []

		@machines.each do |machine|
			if machine.alerts.count > 0
				@machines_with_alerts << machine
			end
		end
	end

	def show
		@machine = Machine.find(params[:id])
	end

	def new
		@machine = Machine.new
		@ex_attrs = ExtendedAttribute.where(model: :machine).order(name: :asc)
		@machine.info ||= {}
	end

	def create
		@machine = Machine.new(machine_params)

		if @machine.save
			redirect_to @machine, notice: "The new machine, #{@machine.name}, has been saved."
		else
			render :new
		end
	end

	def edit
		@machine = Machine.find(params[:id])
		@ex_attrs = ExtendedAttribute.where(model: :machine).order(name: :asc)
		@machine.info ||= {}
	end

	def update
		@machine = Machine.find(params[:id])

		if @machine.update(machine_params)
			redirect_to @machine, notice: "Updated information about #{@machine.name}."
		else
			render :edit
		end
	end

	def manage_ex_attrs
		@ex_attrs = ExtendedAttribute.where(model: :machine).order(name: :asc)
	end

	def destroy
		@machine = Machine.find(params[:id])

		if @machine.destroy
			redirect_to machines_path, notice: "#{@machine.name} has been removed."
		else
			redirect_to @machine, alert: "Error: Could not remove #{@machine.name}."
		end
	end


	private

		def machine_params
			params[:machine][:info] ||= {}
			params[:machine][:info].delete_if { |k,v| v.blank? }
			params.require(:machine).permit!
		end
end