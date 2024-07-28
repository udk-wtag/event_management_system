class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  rescue ActiveRecord::RecordNotFound => e
    redirect_to root_path, alert: "Users not found: #{e.message}"
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    redirect_to new_user_path, alert: "Failed to create user: #{e.message}"
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    redirect_to edit_user_path(@user), alert: "Failed to update user: #{e.message}"
  end

  def destroy
    @user.destroy
    redirect_to root_path, status: :see_other, notice: 'User was successfully deleted.'
  rescue StandardError => e
    redirect_to user_path(@user), alert: "Failed to delete user: #{e.message}"
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    redirect_to root_path, alert: "User not found: #{e.message}"
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
