class ApplicationController < ActionController::API
  include ActionController::RespondWith
  include CanCan::ControllerAdditions
  
  respond_to :json
  before_action :authenticate

  rescue_from(StandardError)                      { head 500, :content_type => "application/json" }
  rescue_from(ActionController::RoutingError)     { head 404, :content_type => "application/json" }
  rescue_from(ActiveRecord::RecordNotFound)       { head 404, :content_type => "application/json" }
  rescue_from(CanCan::AccessDenied)               { head 403, :content_type => "application/json" }
  rescue_from(Errors::UnauthorizedError)          { head 401, :content_type => "application/json" }
  rescue_from(ActionController::ParameterMissing) { head 400, :content_type => "application/json" }
 
  
  def not_found
    raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
  end

  protected
  
  def authenticate
    @current_user = BasicHttpAuthenticator.process(request)
    raise Errors::UnauthorizedError unless @current_user
  end

  def current_user
    @current_user
  end

  def current_ability
    return @current_ability if @current_ability
    @current_ability = Ability.new(current_user)
  end
end
