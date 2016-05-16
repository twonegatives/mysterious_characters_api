{
  :characters => @chars.map do |char|
    render 'character', char: char
  end
}.to_json
