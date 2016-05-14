class UserWithCredentials
  def self.obtain(username, password)
    User.find_by(username: username).try(:authenticate, password)
  end
end
