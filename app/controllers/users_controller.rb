class UsersController < ApplicationController
  # authenticates user before any action
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def update
    if current_user.update_attributes(user_params)
     flash[:notice] = "User information updated"
     redirect_to edit_user_registration_path
    else
     flash[:error] = "Invalid user information"
     redirect_to edit_user_registration_path
    end
  end

  def downgrade
    @user = User.find(params[:id])
    @user.wikis.each do |wiki|
      wiki.update_attribute(:private, false)
    end
    # @user.wikis.update_all(:private, false)
    @user.update_attribute(:role, 'standard')
    redirect_to edit_user_registration_path
  end

  private

  def user_params
   params.require(:user).permit(:name)
  end
end