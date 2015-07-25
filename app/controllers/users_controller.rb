class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :unit,
      :role,
      :building_id,
      :neighborhood_id,
      :email,
      :password,
      :password_confirmation
    )
  end
end
