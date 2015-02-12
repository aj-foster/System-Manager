class ExtendedAttributesController < ApplicationController

	before_filter :authenticate_user!
	before_filter :authorize_user!

	def create
		@ex_attr = ExtendedAttribute.create(ex_attr_params)

		if @ex_attr.save
			redirect_to :back, notice: "The new attribute, #{@ex_attr.name}, has been saved."
		else
			redirect_to :back, alert: "The new attribute could not be saved."
		end
	end


	private

		def ex_attr_params
			params.require(:extended_attribute).permit!
		end
end