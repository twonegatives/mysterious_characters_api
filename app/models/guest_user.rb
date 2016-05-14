class GuestUser < User
  after_initialize :set_defaults

  private

  def set_defaults
    self.username = 'guest'
    self.role     = 'guest' 
  end
end
