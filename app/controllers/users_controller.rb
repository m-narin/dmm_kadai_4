class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def index
    @users = User.all
    @new_book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @new_book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:user_edited] = "You have updated user successfully."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end


  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    if user.id != current_user.id
      redirect_to user_path(current_user.id)
    end
  end
end
