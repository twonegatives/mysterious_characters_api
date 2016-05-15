class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::RespondWith
  include CanCan::ControllerAdditions
  
  respond_to :json
  
  rescue_from(CanCan::AccessDenied)               { head :forbidden,    :content_type => "application/json" }
  rescue_from(ActiveRecord::RecordNotFound)       { head :not_found,    :content_type => "application/json" }
  rescue_from(ActionController::RoutingError)     { head :not_found,    :content_type => "application/json" }
  rescue_from(ActionController::ParameterMissing) { head :bad_request,  :content_type => "application/json" }
 
  #TODO: rescue from internal server error?

  before_action :authenticate
  
  def not_found
    raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
  end

  protected
  
  def authenticate
    @current_user =
      authenticate_with_http_basic do |username, password|
        UserWithCredentials.obtain(username, password)
      end
    @current_user ||= GuestUser.new
  end

  def current_user
    @current_user
  end

  def current_ability
    return @current_ability if @current_ability
    @current_ability = Ability.new(current_user)
  end
end
