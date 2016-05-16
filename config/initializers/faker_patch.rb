module Faker
  class Base
  end
  class Superhero < Base
    class << self
      def name(min_length: 0, max_length: nil)
        tries = 0
        begin
          result = parse('superhero.name')
        end while result.length < min_length and tries < 7
        result = result.first(max_length) if max_length
        result
      end
    end
  end
end
