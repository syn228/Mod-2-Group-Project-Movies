class UsersController < ApplicationController
  before_action :authorized, only: [:edit]

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_path
    end
  end

  def show
    @user = User.find(params[:id])
  end
  def edit
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to current_user
    end
    @movies = Movie.all
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_edit_params)
    if @user.valid?
      redirect_to @user
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to edit_user_path
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.delete
    redirect_to login
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end

  def user_edit_params
    params.require(:user).permit(:username, movie_ids:[])
  end
end
