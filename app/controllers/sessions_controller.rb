class SessionsController < ApplicationController
  before_action :authorize, only: [:secret]

  def secret
  end

  def create
    @user = User.authenticate(params[:email], params[:password])
    if @user
      flash[:notice] = {:content => "You've signed in.", :class => "alert alert-success"}
      session[:user_id] = @user.id
      redirect_to "/"
    else
      flash[:alert] = {:content => "Whoops! There was an error", :class => "alert alert-danger"}
      redirect_to signin_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = {:content => "Signed out", :class => "alert alert-secondary"}
    redirect_to "/"
  end

end
