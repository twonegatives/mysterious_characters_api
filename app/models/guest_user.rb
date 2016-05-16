class GuestUser < User
  after_initialize :set_defaults
  after_initialize :readonly!

  private

  def set_defaults
    self.username = 'guest'
    self.role     = 'guest' 
  end
end
