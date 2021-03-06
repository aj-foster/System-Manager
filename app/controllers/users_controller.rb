class UsersController < ApplicationController

	before_filter :authenticate_user!
	before_filter :authorize_user!

	def index
		@superset = User.order(name: :asc)
		@users, @unapproved = [], []

		@superset.each do |user|
			if user.role == :unapproved
				@unapproved << user
			else
				@users << user
			end
		end
	end

	def show
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])

		if @user.update(user_params)
			redirect_to @user, notice: "Updated information about #{@user.name}."
		else
			errors = @user.errors
			@user = User.find(params[:id])
			errors.each { |error, msg| @user.errors.add error, msg}
			render :show
		end
	end

	def destroy
		@user = User.find(params[:id])

		if @user.destroy
			redirect_to users_path, notice: "#{@user.name} has been removed."
		else
			redirect_to @user, alert: "Error: Could not remove #{@user.name}."
		end
	end

	def approve
		@user = User.find(params[:id])
		@user.role = :approved

		if @user.save
			redirect_to users_path, notice: "#{@user.name} has been approved."
		else
			redirect_to @user, alert: "Error: Could not approve user."
		end
	end


	private

		def user_params
			if params[:user][:password].blank?
				params[:user].delete :password
				params[:user].delete :password_confirmation
			end

			params.require(:user).permit!
		end
end