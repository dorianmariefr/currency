class UsersController < ApplicationController
  before_action :load_user, only: [:show, :destroy]

  def index
    authorize :user
    @users = User.order(created_at: :asc)
  end

  def show
  end

  def new
    @user = authorize User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: t(".notice")
    else
      flash.now.alert = @user.errors.full_messages.to_sentence
      render :new, status: :unprocessable_entity
    end
  end

  private

  def load_user
    @user = authorize User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :password, :slug)
  end
end
