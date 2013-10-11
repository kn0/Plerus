module Plerus
  # The Framework class is used to load mutagen and compiler moduels. It holds the methods needed to randomly select modules.
  class Framework
    attr_reader :mutagens
    attr_reader :compilers

    # Creates a new framework
    # @param path [String] holds location of the base 'evo' folder that contains mutagen and compiler scripts
    def initialize(path)
      @mutagens = Array.new
      @compilers = Array.new
      # Get a list of Evo files and itterate through them all
      Dir.glob("#{path}/**/*.rb").each do |evo_path|
        evo_name = File.basename(evo_path,'.rb')
        # Create an instance of the current module
        evo = load_evo(evo_path)
        # Determine the type of the module with a case statement and then add info to the appropriate instance array
        case evo.type
        when EVO_MUTAGEN
          mutagen = Hash.new
          mutagen[:name] = evo_name
          mutagen[:path] = evo_path
          mutagen[:title] = evo.title
          mutagen[:targets] = evo.targets
          mutagen[:change] = evo.change
          mutagen[:scope] = evo.scope
          @mutagens << mutagen
        when EVO_COMPILER
          compiler = Hash.new
          compiler[:name] = evo_name
          compiler[:path] = evo_path
          @compilers << compiler
        end
      end
    end

    # Returns a random mutagen instance
    def random_mutagen
      load_evo(@mutagens.sample[:path])
      rescue
        return nil
    end


    # Returns a random compiler instance
    def random_compiler
        load_evo(@compilers.sample[:path])
      rescue
        return nil
    end


    # Returns an instance of the evo module defined at a given path.
    # @path [String] The path of the module to be loaded
    def load_evo(path)
      # Load the Evo Module
      load path
      # Create a new instance of the Module
      evo = Evo.new
      # Remove the Evo class (to help keep different methods from stepping on each other)
      Plerus.send(:remove_const, "Evo")
      # Return the new instance of the evo
      return evo
    end


  end
end
