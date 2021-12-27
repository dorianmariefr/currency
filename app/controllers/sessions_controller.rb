class SessionsController < ApplicationController
  before_action :authorize_session

  def new
  end

  def create
    @user = User.find_by(name: name_or_slug)
    @user ||= User.find_by(slug: name_or_slug)

    if !@user
      flash.now.alert = t(".wrong_name_or_slug")
      render :new, status: :unprocessable_entity
    elsif @user.authenticate(password)
      session[:user_id] = @user.id
      redirect_to root_path, notice: t(".notice")
    else
      flash.now.alert = t(".wrong_password")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil

    redirect_to root_path
  end

  private

  def authorize_session
    authorize :session
  end

  def session_params
    params.require(:session).permit(:name_or_slug, :password)
  end

  def name_or_slug
    session_params[:name_or_slug]
  end

  def password
    session_params[:password]
  end
end
