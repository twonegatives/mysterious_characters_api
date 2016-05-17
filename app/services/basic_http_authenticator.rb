class BasicHttpAuthenticator
  
  def self.process input_request
    self.new(input_request).authenticate
  end

  def initialize input_request
    @request = input_request
  end

  def authenticate
    ActionController::HttpAuthentication::Basic.authenticate(@request) do |username, password|
      User.find_by(username: username).try(:authenticate, password)
    end
  end

end
