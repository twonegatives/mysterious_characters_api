{
  name:     @char.name,
  health:   @char.health,
  strength: @char.strength,
  user: {
    id:       @char.user.id,
    username: @char.user.username
  }
}.to_json
