class UsersController < ApplicationController
  before_action :authorize, only: [:secret]

  def secret
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = {:content => "You've signed up!", :class => "alert alert-success"}
      session[:user_id] = @user.id
      redirect_to "/"
    else
      flash[:alert] = {:content => "Whoops! There was an error", :class => "alert alert-danger"}
      redirect_to '/signup'
    end
  end

  def destroy
    if @user == current_user
      @user.destroy
      redirect_to "/signout"
    else
      @user.destroy
      redirect_to "/"
    end
  end

  private
    def user_params
      params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
    end

end
