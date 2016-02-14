class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :notifications, :comments
  before_filter :tracking
  
  def notifications
    @notifications = Notification.all
    @notifications.each do |notification|
      notification.update_attribute(:check, true)
    end
  end

  def comments
    @comments = Comment.all
  end

  def tracking
    @tracks = Track.all 
    @track = @tracks.each { |track| track }
  end


  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
    end
end
