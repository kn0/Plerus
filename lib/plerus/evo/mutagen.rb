module Plerus
  # This class acts as the parent class for all evo Mutagen objects
  class Mutagen
    attr_reader :change
    attr_reader :targets
    attr_reader :type
    attr_reader :scope
    attr_reader :title
    attr_reader :safe

    def initialize(info)
      @type   = EVO_MUTAGEN
      @targets = info[:targets]
      @change = info[:change]
      @scope  = info[:scope]
      @safe   = info[:safe] || false
      @title  = info[:title]
    end

  end
end
