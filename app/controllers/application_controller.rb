# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit

  helper_method :current_user

  def current_user
    return if session[:user_id].blank?
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
