class UsersController < ApplicationController

  before_action :check_if_owner, only: [:index]
  def index
    @users = User.where(owner: false).order(:first_name)
    @employees = Employee.all
  end



  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to :back
  end

  private

  def user_params
    params.require(:user).permit(:admin)
  end

  def check_if_owner
    unless current_user.present? && current_user.owner?
      redirect_to root_path, notice: "You are not allowed to do that."
    end
  end
end
