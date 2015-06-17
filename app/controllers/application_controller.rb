class ApplicationController < ActionController::Base
  include Pundit
  # protects you from people attacking your app
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protection 
  protect_from_forgery with: :exception


  rescue_from Pundit::NotAuthorizedError do |exception|
    redirect_to root_url, alert: exception.message
  end
end
