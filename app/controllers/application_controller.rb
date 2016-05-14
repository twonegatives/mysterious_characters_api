class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include CanCan::ControllerAdditions
  
  rescue_from(CanCan::AccessDenied)               { head :forbidden }
  rescue_from(ActiveRecord::RecordNotFound)       { head :not_found }
  rescue_from(ActionController::RoutingError)     { head :not_found }
  rescue_from(ActionController::ParameterMissing) { head :bad_request }
  
  before_action :authenticate
  
  def not_found
    raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
  end

  protected
  
  def authenticate
    authenticate_with_http_basic do |username, password|
      @current_user = UserWithCredentials.obtain(username, password) || GuestUser.new
    end
  end

  def current_user
    @current_user
  end

  def current_ability
    return @current_ability if @current_ability
    @current_ability = Ability.new(current_user)
  end
end
