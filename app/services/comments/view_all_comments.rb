class ViewAllComments
  DEFAULT_LIMIT   = 20
  DEFAULT_OFFSET  = 0

  def self.obtain ability, parameters
    self.new(ability, parameters).obtain
  end

  def initialize ability, parameters
    @ability    = ability
    @parameters = parameters
  end

  def obtain
    comments = Comment.accessible_by(@ability).
                       where(character_id: @parameters[:character_id]).
                       limit(limit).offset(offset).
                       includes(:user).all
  end

  private

  def limit
    @parameters[:limit] || DEFAULT_LIMIT
  end

  def offset
    @parameters[:offset] || DEFAULT_OFFSET
  end
end
