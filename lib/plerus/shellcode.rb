module Plerus
  # The Shellcode class holds information about a given piece of shellcode and it's mutation history
  class Shellcode
    attr_accessor :raw
    attr_reader   :generation
    attr_accessor :log
    attr_accessor :mutations

    # Creates a new Shellcode object
    # @param shellcode [String] String holding the raw shellcode
    # @param generation [Fixnum] Value to show which generation the shellcode belongs to
    def initialize(shellcode, generation = 1)
      # TODO Convert raw shellcode to correct format using Metasm
      @raw = shellcode
      @fitness = nil
      @generation = generation
      @log = Array.new
      @mutations = 0
    end


    # Deep clones the Plerus::Shellcode object
    def clone
      # Since the array is multidimensional we have to use the Marshal trick to get a true dupe
      new_shellcode = Marshal.load(Marshal.dump(@raw))
      sc = Plerus::Shellcode.new(new_shellcode, @generation)
      # Copy over the log
      sc.log = Marshal.load(Marshal.dump(@log))
      # Set the total number of mutations
      sc.mutations = @mutations
      return sc
    end


    # Mutates shellcode according to a mutagen at a pseudo-random location
    # @param mutagen [Plerus::Mutagen] The mutgen to be used
    def mutate(mutagen)
      # If the mutagen has a target instruction, find where the shellcode has the given target
      if mutagen.targets
        loci = self.locus(mutagen.targets)
        if loci.is_a? Array
          target = loci.sample
        else
          target = nil
        end
      else
        target = ( rand(self.genes) + 1 )
      end

      # If no target instructions exist
      return [generation, @mutations, nil,"No Target Found"] if target.nil?

      # Mutate the shellcode at the pseudo-randomly determined loci with the provided mutagen
      self[target] = mutagen.mutate(self[target])

      # Increment the total number of mutations in the shellcodes life
      @mutations += 1

      # Add information to the @log and return the most recent entry
      @log << [generation, @mutations, target, mutagen.title]
      @log.last
    end


    # Increments the shellcode generation number
    def next_generation
      @generation += 1
    end


    # Mutate the gene that contains the instructions at 'location' with the provided mutagen
    # @param location [Fixnum] The gene location to mutate with the given mutagen
    # @param mutagen [Plerus:Mutagen] The object used to 'mutate' the code located at the given target
    def point_mutation(location, mutagen)
      # Make sure the mutation is actually possible
      raise "Shellcode doesn't contain a valid target for the provided mutagen" if ((not mutagen.targets.nil?) and locus(mutagen.targets).nil?)
      # If so, mutate away
      self[location] = mutagen.mutate(self[location])
      # Increment the mutations count and add an entry to the log
      @mutations += 1
      @log << [generation,@mutations, location, mutagen.title]
      @log.last
    end


    # Returns the location of intructions of all points that contain a given piece of shellcode
    # If multiple values are given in an array, it will return all locations that contain ANY values included
    # This should not to be confused with an array index. It is the location by instruciton count.
    def locus(value)
      value = [value] unless value.is_a? Array
      count = 1
      locations = Array.new
      @raw.each do |gene|
        gene.each do |ins|
          value.each do |val|
            if val == ins
              locations << count
              break
            end
          end
          count += 1
        end
      end
      if locations.empty?
        return nil
      else 
        return locations
      end
    end 


    # Returns the total number of 'genes'
    def genes
      @raw.flatten.count
    end
       

    # Does the dirty
    def mate(shellcode)
      # Work in progress. Removed until it works better.
    end


    # Converts the shellcode to raw hex
    def to_hex
      @raw.flatten.join.scan(/../).map {|x| x.hex.chr}.join
    end


    # Converts the shellcode to a nice hex string
    def to_s
      string = ""
      @raw.join.scan(/../).map {|hex| string << "\\x#{("%02s"%hex).tr(' ','0')}"}.join
      return string
    end

# --------------- Shellcode 'Array' Helpers -------------------------------------
    # Allow access to shellcode gene like an array, except references instruction count instead of the actual array location.
    # Returns the whole gene that contains the instruction at the provided count
    # Unlike Ruby arrays, this makes use of a One-Based index.
    def [](n)
      count = 1
      @raw.each do |gene|
        gene.each do |ins|
          if count == n
            return gene
          end
          count += 1
        end
      end
      return nil
    end


    # Provides ability to change shellcode gene like an array. Replaces gene in @raw with value if gene contains instruction 'n'.
    def []= (n,value)
      count = 1
      gene_loci = 0
      @raw.each do |gene|
        instruction = 0
        gene.each do |ins|
          if count == n
            @raw[gene_loci] = value
            return value
          end
          count += 1
          instruction += 1
        end
        gene_loci += 1
      end
      return nil
    end

    # Provides an instruction count (one-indexed)
    def count
      count = 0
      @raw.each do |gene|
        gene.each do |ins|
          count += 1
        end
      end
      return count
    end

  end
end
