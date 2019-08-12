class SessionsController < ApplicationController
  before_action :authorize, only: [:secret]

  def secret
  end

  def new
    # this is weird and we found out that by default rails will just go to "new" in the views folder
    # this lets us redirect a user if they are already logged in
    if session[:user_id]
      redirect_to topics_path
    end
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
