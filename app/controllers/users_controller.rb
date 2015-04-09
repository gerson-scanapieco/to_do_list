class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = 
      params[:id].nil? ? current_user : User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to edit_user_path(@user), notice: "Alterações salvas com sucesso"
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
