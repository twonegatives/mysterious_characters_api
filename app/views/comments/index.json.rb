{
  :comments => @comments.map do |comment|
    {
      id:       comment.id,
      body:     comment.body,
      user: {
        id:       comment.user.id,
        username: comment.user.username
      }
    }  
  end
}.to_json
