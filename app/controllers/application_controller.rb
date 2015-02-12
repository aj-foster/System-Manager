class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception
	protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
	before_filter :configure_permitted_parameters, if: :devise_controller?

	# Check the current user's role attribute and sign out any user who has not
	# been approved.
	#
	def authorize_user!
		unless current_user.role.to_sym == :approved
			sign_out_and_redirect current_user
			flash[:alert] = "Your account has not been approved for access."
		end
	end

	protected
		def configure_permitted_parameters
			devise_parameter_sanitizer.for(:sign_up) << :name
		end
end