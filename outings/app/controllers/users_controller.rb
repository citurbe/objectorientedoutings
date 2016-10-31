class UsersController < ApplicationController

  skip_before_action :require_login, only: [:new,:create]

  def show
    @user = User.find(params[:id])


    @bar_chart_data = @user.reviews.group(:score).order(score: :desc).count.map do |key,val|
      ["Rated #{key}",val]
    end
    @bar_library = {library: {
      width:600,
      hAxis: {format: '###'}
      }}


    @plan_chart_data = @user.plans.group_by_day(:timing).count.map do |key,val|
      [key,val] if key >= 5.days.ago
    end.compact!
    @plan_chart_library = {library:{
      width:600,
      crosshair: {
        trigger: 'focus',
        orientation: 'both',
        focused: { color: '#3bc', opacity: 0.8 }
      },
      vAxis:{
        gridlines: {count:0}
      },
      hAxis:{
        format:'MMM d',
        gridlines:{count:6}
      }
    }}
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
      flash[:notice] = @user.errors.messages
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
