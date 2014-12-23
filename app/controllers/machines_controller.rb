class MachinesController < ApplicationController

	def index
		@machines = Machine.order(name: :asc)
	end

	def show
		@machine = Machine.find(params[:id])
	end

	def new
		@machine = Machine.new
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
	end

	def update
		@machine = Machine.find(params[:id])

		if @machine.update(machine_params)
			redirect_to @machine, notice: "Updated information about #{@machine.name}."
		else
			render :edit
		end
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
			params.require(:machine).permit!
		end
end