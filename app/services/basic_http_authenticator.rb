class BasicHttpAuthenticator
  
  def self.process input_request
    self.new(input_request).authenticate
  end

  def initialize input_request
    @request = input_request
  end

  def authenticate
    login_user or guest_user 
  end

  private

  def login_user
    ActionController::HttpAuthentication::Basic.authenticate(@request) do |username, password|
      User.find_by(username: username).try(:authenticate, password)
    end
  end

  def guest_user
    GuestUser.new
  end
end
