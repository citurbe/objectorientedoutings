class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @organizations = Organization.all
  end

  def create
    @user = User.new(user_params(:name, :email, :password, :password_confirmation, :phone, :user_name, :organization_id))
  #  byebug
    if params[:user][:password] == params[:user][:password_confirmation] && @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:notice] = "Invalid logup data"
      redirect_back fallback_location: "/"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update

  end

  private

  def user_params(*args)
    params.require(:user).permit(args)
  end
end
