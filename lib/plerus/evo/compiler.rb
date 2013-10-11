module Plerus
  # This class acts as the parent for all evo Compiler objects
  class Compiler
    attr_reader :title
    attr_reader :safe
    attr_reader :type
    attr_reader :authors #TODO
    
    def initialize(info)
      @type   = EVO_COMPILER
      @title  = info[:title]
      @safe   = info[:safe] || false
    end

    # Creates a random name to be used by the compiler
    def random_name(length = 10, char_set = nil)
      if char_set.eql? nil
        char_set = [('a'..'z'), ('A'..'Z')].map {|i| i.to_a }.flatten
      end
      name = (0...length).map{ char_set[rand(char_set.length)] }.join
    end

  end
end
