class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      cookies.encrypted[:user_id] = user.id
      redirect_to root_url, notice: 'Logged in!'
    else
      flash.now[:alert] = 'Email or password is invalid'
      render 'create'
    end
  end

  def destroy
    cookies.delete(:user_id)
    redirect_to root_url, notice: 'Logged out!'
  end
end
