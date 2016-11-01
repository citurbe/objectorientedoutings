class UsersController < ApplicationController

  skip_before_action :require_login, only: [:new,:create]

  def show
    @user = User.find(params[:id])
    # @review_chart_data = @user.review_chart_data
    # @bar_chart_library = @user.review_chart_library
    # @plan_chart_data = User.activity(@user)
    @line_chart_library = @user.line_chart_library
  end

  def new
    @user = User.new
    @organizations = Organization.all
  end

  def create
  #  byebug
    present_params = params[:user].select{|k, v| params[:user][k] != ""}
    @user = User.new(user_params(present_params.keys))
  #  byebug
    if params[:user][:password] == params[:user][:password_confirmation] && @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:notice] = @user.errors.full_messages
      redirect_back fallback_location: "/"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params(:name, :email, :phone, :user_name))
    if !@user.errors.messages.empty?
      flash[:notice] = @user.errors.messages
      redirect_to edit_user_path(@user)
    else
      redirect_to user_path(@user)
    end
  end

  private

  def user_params(*args)
    params.require(:user).permit(args)
  end
end
