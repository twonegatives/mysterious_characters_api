{
  :characters => @chars.map do |char|
    {
      id:       char.id,
      name:     char.name,
      health:   char.health,
      strength: char.strength,
      user: {
        id:       char.user.id,
        username: char.user.username
      }
    }  
  end
}.to_json
