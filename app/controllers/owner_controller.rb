class OwnerController < ApplicationController
  before_action :check_if_owner

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_back(fallback_location: root_path, notice: "#{@user.first_name}s account has been deleted.")
  end
  def make_admin
    @user = User.find(params[:id])
    @user.update_attribute :admin, true
    redirect_back(fallback_location: root_path, notice: "#{@user.first_name} is now an admin.")
  end

  def remove_admin
    @user = User.find(params[:id])
    @user.update_attribute :admin, false
    redirect_back(fallback_location: root_path, notice: "#{@user.first_name}'s Admin rights removed.")
  end

  private

  def user_params
    params.require(:user).permit(:admin)
  end

  def check_if_owner
    if current_user.owner == false
      redirect_to root_path
    end
  end
end
