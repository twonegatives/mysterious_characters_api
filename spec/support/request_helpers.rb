module Requests
  module JsonHelpers
    def json
      JSON.parse(response.body)
    end

    def auth_header
      { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(user.username, user.password) }
    end
  end
end
