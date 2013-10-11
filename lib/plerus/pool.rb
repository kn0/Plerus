module Plerus
  # This class is used to hold and manage various mutants within a generation, as well as provide high level methods to move the genetric algorithm process along.
  class Pool
    attr_accessor :framework
    attr_accessor :population
    attr_reader :base

    # Creates a new pool that can be used to hold and evolve many different instances of shellcode
    # @param framework [Plerus::Framework] Plerus Framework object used to get mutagens and compilers
    # @param shellcode [Plerus::Shellcode] Plerus Shellcode object used as a starting point
    # @param size [Fixnum] The size of the pool (how many different Plerus::Shellcode objects can be held)
    def initialize(framework, shellcode, size = Plerus::DEFAULT_POOL_SIZE, generation=1)
      # Store the starting point as @base
      if shellcode.is_a? Plerus::Shellcode
        @base = shellcode
      else
        @base = Plerus::Shellcode.new(shellcode)
      end
      # Setup the population, add the base, and the fill it up with mutated shellcode
      @population = Array.new
      # Make the first instance of the pool the default (unless the pool is only big enough for one piece of code)
      unless size <= 1
        @population << @base 
        size -= 1
      end
      # Fill the pool with randonly mutated pieces of shellcode
      size.times do 
        # Create a clone of the base shellcode
        sc = @base.clone
        # Randomly figure out how many mutations to do.
        # Too many mutations will probably 'kill' the code (think cancer).
        # Too few, will require way too many generations to get something useful.
        mutations = (Plerus::DEFAULT_MIN_MUTATIONS_PER_GENERATION..Plerus::DEFAULT_MAX_MUTATIONS_PER_GENERATION).to_a.sample
        # Mutate the code with a randomly selected mutagen
        while mutations > 0
          sc.mutate(framework.random_mutagen)
          mutations -= 1
        end
        # Add the mutated code to the pool's population
        @population << sc
      end
    end


    # Shortcut for self.population.each
    def each &block
      self.population.each(&block)
    end


    # Access individual shellcode objects (note: this is zero-indexed)
    def [](n)
      return @population[n]
    end

  end
end
