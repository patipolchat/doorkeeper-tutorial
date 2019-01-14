class UsersController < ApplicationController
  before_action :doorkeeper_authorize!
  before_action :set_user, only: [:show, :update, :destroy]
  
  def index
    render json: User.all
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render status: 422, json: { error: @user.errors.full_messages } 
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render status: 422, json: { error: @user.errors.full_messages } 
    end
  end

  def destroy
    @user.destroy
    render :ok
  end

  private

  def user_params
    params.require(:users).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
